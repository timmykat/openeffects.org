class NewsItem < ActiveRecord::Base

  include Ofx::HtmlSanitizer
  
  before_validation :sanitize_textareas
  validates :headline, :presence => true, :length => { maximum: 100, message: "Your headline can be no more than 100 characters." }
  validates :date, :presence => true
  validates :summary, :presence => true
  validates :published, :inclusion => { in: [true, false] }

  def self.build_panel(num = 3)
    NewsItem.where(published: true).limit(num).to_a
  end
end
