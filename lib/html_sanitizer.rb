# This module sanitizes all the text columns of the given instance
module HtmlSanitizer
  def sanitize_textareas
    self.class.columns.map { |c| [c.name, c.type] }.each do |attr, type|
      if type == :text and !attributes[attr].blank?
        attributes[attr] = ofx_sanitize(attributes[attr])
      end
    end
  end
  
  private
    def ofx_sanitize(html)
      html = clean_docuwiki(html)
      Sanitize.clean(html, Sanitize::Config::RELAXED.merge( Rails.configuration.ofx[:sanitizer] ))
    end          

    def clean_docuwiki(html)
      html_array = html.split("\n")
      html_array.each do |l|
        l.gsub!(/\t/,'  ')
        l.gsub!(/<\/?div[a-z0-9= ]>/,'')
        l.gsub!(/ class="level\d+"/, '')
      end
      html_array.reject! { |x| x.blank? or x == "\n" }
      html_array.join("\n")
    end

end