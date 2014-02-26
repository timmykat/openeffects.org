class NewsItem < ActiveRecord::Base
  include Publishable
  
  validates :headline, :presence => true, :length => { maximum: 100, message: "Your headline can be no more than 100 characters." }
  validates :date, :presence => true
  validates :summary, :presence => true
  before_validation :sanitize_html

  def self.build_panel(num = 3)
    NewsItem.where(published: true).limit(num).to_a
  end

  private
    def sanitize_html
      self.summary = Sanitize.clean(self.summary, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
          }
        }))
    end
end
