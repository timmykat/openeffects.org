module Ofx
  class DocPrep
    @@xsl = Nokogiri::XSLT(File.read(File.join(File.dirname(__FILE__), 'assets', 'stylesheets', 'pretty_print.xsl')))
    @@fileroot = "ofx-docbook-nav"
    @@ofx_css = "#{@@fileroot}.css"
    @@inserted_html = File.read(File.join(Rails.root, 'lib','ofx', 'assets', "#{@@fileroot}.html"))
    @@ofx_js_fixer = "ofx-docbook-image-fixer.js"

    def initialize(doc_type)
      @type = doc_type
      @source_dir = File.join(Rails.root,'public', 'unprepped',@type)
      @docs_dir_path = 'documentation'
      @doc_dir = File.join(@docs_dir_path,@type)
      @destination_dir = File.join(Rails.root,'public',@doc_dir)
    end
    
    def process_directory(sse = nil)

      ## Clear and remake the destination directory and asset directory
      %x[ rm -r #{@destination_dir} ]
      %x[ mkdir -p "#{@destination_dir}" ]
      
      ## Copy the ofx css/image assets to public/assets
      %x[ cp #{File.join(File.dirname(__FILE__),'assets','copy_to_assets', "*")} #{File.join(Rails.root, 'public', 'assets')} ]

      Dir["#{@source_dir}/*"].each do |file|
    
        next if File.directory?(file)
        
        filename = File.basename(file)
        
        # Define css/js-processing lambda     
        process_asset_file = lambda { |file, regex, replace|
          filename = File.basename(file)
          File.open(File.join(@destination_dir, filename), 'w') do |f_write|
            File.open(file) do |f_read|
              f_read.each_line do |line|
                f_write.write line.gsub(regex, replace)
              end
            end
          end
        }
        
        case filename
          when /\.css$/
            if sse.nil?
              puts "Processing css: #{filename}"
            else
              sse.write "Processing css: #{filename}"
            end  
            # Make url refs absolute
            process_asset_file.call(file, /url\(('[a-zA-Z_0-9].*\.(png|jpg|gif)')\)/, "url('/#{@doc_dir}/#{$1}')")
            
          when /\.js$/
            if sse.nil?
              puts "Processing js #{filename}"
            else
              sse.write "Processing js: #{filename}"
            end
            # Make url refs absolute
            process_asset_file.call(file, /"([a-zA-Z_0-9].*\.html(#[a-zA-Z_0-9].*){0.1})"/, "\"/#{@doc_dir}/#{$1}\"")
            
          when /\.html$/
            if sse.nil?
              puts "Processing html #{filename}"
            else
              sse.write "Processing html: #{filename}"
            end
            input_xml = Nokogiri::XML(open(file))
        
            # Update all html references with the correct directory
            input_xml.css('a,link').each do |link|
              if /\.html$/.match(link['href'])
                link['href'] = link['href'].insert(0, "/#{@doc_dir}/")
              elsif link.name == 'link' and link['href'] == 'ofxStyle.css'
                link['href'] = link['href'].insert(0, "/assets/")
              end
            end

            #Add the ofx nav styling link to head
            input_xml.at_css('head').add_child("<link rel='stylesheet' type='text/css' href='/assets/#{@@ofx_css}'>")          
          
            # Now insert the html
            case @type
              when 'api_doc'
                input_xml.at_css('#top').children.first.add_previous_sibling(@@inserted_html)            
              when 'guide', 'reference'
                body = input_xml.at_css('body')
                body.inner_html = "<div class='wrapper' id='#{@type}'>#{body.inner_html}</div><!--.wrapper-->"
                body.children.first.add_previous_sibling(@@inserted_html)  
            end
          
          
            File.open("#{@destination_dir}/#{filename}", 'w') { |f| f.write(@@xsl.apply_to(input_xml).to_s) }
            
          else  
           if sse.nil?
              puts "Copying file: #{filename}"
            else
              sse.write "Copying file: #{filename}"
            end
            %x( cp #{file} #{@destination_dir} )
#            %x( cp #{file} "#{File.join(Rails.root, 'public', @docs_dir_path)}" )
         end
       end
      end
    end
end
