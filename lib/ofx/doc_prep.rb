module Ofx
  class DocPrep
    @@xsl = Nokogiri::XSLT(File.read("#{File.dirname(__FILE__)}/assets/stylesheets/pretty_print.xsl"))
    @@fileroot = "ofx-docbook-nav"
    @@link_to_css = "/assets/#{@@fileroot}.css"
    @@inserted_html = File.read("#{Rails.root}/public/assets/#{@@fileroot}.html")

    def initialize(doc_type)
      unless %w(api_ref guide).include? doc_type
        puts "The document type must be 'api_ref' or 'guide'"
        exit
      end
      @type = doc_type
      @source_dir = "#{Rails.root}/public/unprepped/#{@type}"
      @destination_dir = "#{Rails.root}/public/#{@type}"
    end
    
    def process_directory
      Dir["#{@source_dir}/*"].each do |file|
        filename = File.basename(file)
        
        unless /\.html$/.match(filename)
          puts "Copying #{filename}"
          %x( cp #{file} #{@destination_dir} )
        else
          puts "Processing #{filename}"
          input_xml = Nokogiri::XML(open(file))
        
          #Add the link to the CSS file
          input_xml.at_css('head').add_child("<link rel='stylesheet' type='text/css' href='#{@@link_to_css}'>")
 
          # Now insert the html
          case @type
            when 'api_ref'
              input_xml.at_css('#top').children.first.add_previous_sibling(@@inserted_html)            
            when 'guide'
              body = input_xml.at_css('body')
              body.inner_html = "<div class='wrapper'>#{body.inner_html}</div><!--.wrapper-->"
              body.children.first.add_previous_sibling(@@inserted_html)  
          end
          File.open("#{@destination_dir}/#{filename}", 'w') { |f| f.write(@@xsl.apply_to(input_xml).to_s) }
        end
      end
    end

  end
end
