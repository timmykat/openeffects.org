# This module sanitizes all the text columns of the given instance
module Ofx
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
        Sanitize.clean(html, Sanitize::Config::RELAXED.merge( Rails.configuration.ofx[:sanitizer] ))
      end          
  end
end