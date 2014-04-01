require 'json'

class ApiDocsController < ApplicationController
  include ActionController::Live  # See https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/live.rb
  
  # The command takes two parameters:
  # 1) ENV-local OpenFX repo location (from ofx yaml configuration file)
  # 2) Release identifier (from dashboard)
  
  def update
    response.headers['Content-Type'] = 'text/event-stream'
    
    docs_source_dir = Rails.configuration.ofx[:support_docs]['repo'][Rails.env]
    cmd = "#{Rails.root}/lib/ofx/scripts/pullLatestRelease.sh #{docs_source_dir} #{params[:release]} 2>&1"

    # First generate the release
    io = IO.popen(cmd, 'r')
    logger.info("INFO - Running script, writing info")
    while (line = io.gets)
      response.stream.write("event: terminal-output\n")
      response.stream.write("data: #{line}\n\n")
    end
    io.close

    # Then copy to the unprepped directory (need to make a link for production)
    case Rails.env
      when 'development'
        logger.info("INFO - Making docs, working in #{Rails.root}")
        destination_dir = File.join(Rails.root, 'public', 'unprepped')
      when 'production'
        logger.info("INFO - Making docs, working in #{Rails.configuration.ofx[:deploy_dir]}")
        destination_dir = File.join(Rails.configuration.ofx[:deploy_dir], 'shared', 'public', 'unprepped')
    end
    logger.info("INFO - remaking #{destination_dir}")
    
    response.stream.write("event: terminal-output\n")
    response.stream.write("data: Removing old 'unprepped' directories\n\n")

    %x[ rm -r #{destination_dir} ]

    response.stream.write("event: terminal-output\n")
    response.stream.write("data: Making new 'unprepped' directories\n\n")
    api_doc_dir = File.join(destination_dir, 'api_doc')
    %x[ mkdir -p #{api_doc_dir} ]
    guide_dir = File.join(destination_dir, 'guide')
    %x[ mkdir -p #{guide_dir} ]
    reference_dir = File.join(destination_dir, 'reference')
    %x[ mkdir -p #{reference_dir} ]
    
    # Additional step for production of ensuring the link from current to shared
    if (Rails.env == 'production')
      response.stream.write("event: terminal-output\n")
      response.stream.write("data: Creating 'unprepped' shared directory link\n\n")
      
      cmd = "ln -s #{destination_dir} #{File.join(Rails.root, 'public', 'unprepped')}"
      %x[ #{cmd} ]
      response.stream.write("event: terminal-output\n")
      response.stream.write("data: #{cmd}\n\n")
    end

    response.stream.write("event: terminal-output\n")
    response.stream.write("data: Moving docs into 'unprepped' directory\n\n")

    cmd = "cp -r #{File.join(docs_source_dir, 'doc', 'html', '*')} #{api_doc_dir}"
    %x[ #{cmd} ]
    response.stream.write("event: terminal-output\n")
    response.stream.write("data: #{cmd}\n\n")

    cmd = "cp -r #{File.join(docs_source_dir, 'Documentation', 'Guide', '*')} #{guide_dir}"
    %x[ #{cmd} ]
    response.stream.write("event: terminal-output\n")
    response.stream.write("data: #{cmd}\n\n")

    cmd = "cp -r #{File.join(docs_source_dir, 'Documentation', 'Reference', '*')} #{reference_dir}"
    %x[ #{cmd} ]
    response.stream.write("event: terminal-output\n")
    response.stream.write("data: #{cmd}\n\n")

    response.stream.write("event: terminal-output\n")
    response.stream.write("data: DONE\n\n")
      
    response.stream.write("event: eof\n")
    response.stream.write("id: last-event\n")
    response.stream.write("data: EOF\n\n")
     
  ensure
    response.status = 304
    response.stream.close
    render :json => { status: :ok }
  end
    
  def insert_nav
    process_doc = params[:process_doc] || 'all'
    response.headers['Content-Type'] = 'text/event-stream'

    $stdout.sync = true
    Rails.configuration.ofx[:support_docs]['docs'].each do |doc|
      next unless process_doc == 'all' || process_doc == doc
      response.stream.write("event: terminal-output\n")
      response.stream.write("data: #{doc.upcase}\n\n")
      p = Ofx::DocPrep.new(doc)
      p.process_directory(response.stream)
    end
    
    response.stream.write("event: terminal-output\n")
    response.stream.write("data: DONE\n\n")
    
    response.stream.write("event: eof\n")
    response.stream.write("id: last-event\n")
    response.stream.write("data: EOF\n\n")
  ensure
    response.status = 304
    response.stream.close

    render json: { status: 'ok' }
  end  
end