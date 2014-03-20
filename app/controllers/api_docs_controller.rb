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
  
  def test
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Access-Control-Allow-Origin'] = '*'
    sse = ServerSide::SSE.new(response.stream)
    begin
      10.times {
        sse.write({ :message => "This is my message}" }.to_json)
        sleep 1
      }
    rescue IOError
    ensure
      sse.close
    end
  end
  
  def update
    if params[:release].blank?
      respond_to do |format|
        format.json { render :json => { error: 'Please specify a release' }}
      end
    else
      cmd = "#{Rails.root}/lib/ofx/scripts/pullLatestRelease.sh #{Rails.configuration.ofx[:documentation_repo][Rails.env]} #{params[:release]} 2>&1"
      response.headers['Content-Type'] = 'text/event-stream'
      response.headers['Access-Control-Allow-Origin'] = '*'
      sse = ServerSide::SSE.new(response.stream)
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
    %x( bundle exec rake 'ofx:prep_docs' )  
    respond_to { |format| format.json { render :json => { :data => 'Done' }}}
  end  
end