# SSE module
require 'json'
 
module ServerSide
  class SSE
    def initialize io
      @io = io
    end
 
    def write object, options = {}
      options.each do |k,v|
        @io.write "#{k}: #{v}n"
      end
      @io.write "data: #{object}\n\n"
    end
 
    def close
      @io.close
    end
  end
end

# See http://andowebsit.es/blog/noteslog.com/post/how-to-run-rake-tasks-programmatically/
# require 'rake'
# load File.join(Rails.root, 'lib', 'tasks', 'ofx.rake')
class ApiDocsController < ApplicationController
  include ActionController::Live 
    
  def update
    if params[:release].blank?
      respond_to do |format|
        format.json { render :json => { error: 'Please specify a release' }}
      end
    else
      sse = ServerSide::SSE.new(response.stream)
      response.headers['Content-Type'] = 'text/event-stream'
      response.headers['Access-Control-Allow-Origin'] = '*'
      
      # Handle the unprepped document directory
      # Handle differently for dev and production
      sse.write("Remaking unprepped doc directories<br/>")
      case Rails.env
        when 'development'
          logger.info("Making docs - working in #{Rails.root}")
          base_dir = Rails.root
        when 'production'
          logger.info("Making docs - working in #{Rails.configuration.ofx[:deploy_dir]}")
          base_dir = File.join(Rails.configuration.ofx[:deploy_dir], 'shared')
      end          
      %x[ rm -r #{File.join(base_dir, 'public', 'unprepped')} ]
      %x[ mkdir -p #{File.join(base_dir, 'public', 'unprepped', 'api_doc')} ]
      %x[ mkdir -p #{File.join(base_dir, 'public', 'unprepped', 'guide')} ]
      %x[ mkdir -p #{File.join(base_dir, 'public', 'unprepped', 'reference')} ]
      
      # Additional step for production of ensuring the link from current to shared
      if (Rails.env == 'production')
        %x[rm #{File.join(Rails.root, 'public', 'unprepped')}]
        %x[ln -s #{File.join(base_dir, 'public', 'unprepped')} #{File.join(Rails.root, 'public', 'unprepped')}]
      end 
        
      cmd = "#{Rails.root}/lib/ofx/scripts/pullLatestRelease.sh #{Rails.configuration.ofx[:support_docs]['repo'][Rails.env]} #{params[:release]} #{Rails.env} 2>&1"
      IO.popen(cmd, 'r') do |io| 
        begin
          while (line = io.gets)
            sse.write(line)
          end
        ensure
          response.status = 304
          sse.close
        end
      end
    end
  end
  
  def insert_nav
    process_doc = params[:process_doc] || 'all'
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Access-Control-Allow-Origin'] = '*'
    sse = ServerSide::SSE.new(response.stream)
    $stdout.sync = true
    begin
      Rails.configuration.ofx[:support_docs]['docs'].each do |doc|
        next unless process_doc == 'all' || process_doc == doc
        sse.write "#{doc.upcase}"
        p = Ofx::DocPrep.new(doc)
        p.process_directory(sse)
      end
      sse.write "DONE\n"
    ensure
      response.status = 304
      sse.close
    end
    render json: { status: 'ok' }
  end  
end