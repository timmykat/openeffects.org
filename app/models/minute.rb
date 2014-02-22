class Minute < ActiveRecord::Base
  include Publishable
  
  validates :meeting, :presence => true, :inclusion => ['agm', 'dirs']
  validates :date, :presence => true
  validates :members, :presence => true
  validates :minutes, :presence => true
  before_validation :sanitize_html
  
  def self.build_panel(type, num = 3)
    Minute.where(meeting: type).limit(num).pluck(:date)
  end

  private
    def sanitize_html
      self.members = Sanitize.clean(self.members, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
      self.observing = Sanitize.clean(self.observing, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
      self.minutes = Sanitize.clean(self.minutes, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
    end
  
end
