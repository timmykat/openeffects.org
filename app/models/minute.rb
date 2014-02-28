class Minute < ActiveRecord::Base
  include Publishable
  
  validates :meeting, :presence => true, :inclusion => Rails.configuration.ofx['meeting_type'].keys
  validates :date, :presence => true
  validates :members, :presence => true
  validates :minutes, :presence => true
  before_validation :sanitize_html
  
  def self.build_panel(type, num = 3)
    Minute.where(meeting: type, published: true).limit(num)
  end

  private
    def sanitize_html

      self.members = clean_docuwiki(self.members)
      self.members = Sanitize.clean(self.members, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))

      self.observing = clean_docuwiki(self.observing)
      self.observing = Sanitize.clean(self.observing, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
        
      self.minutes = clean_docuwiki(self.minutes)
      self.minutes = Sanitize.clean(self.minutes, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
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
