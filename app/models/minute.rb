class Minute < ActiveRecord::Base

  include ::HtmlSanitizer
  
  before_validation :sanitize_textareas
  validates :meeting, :presence => true, :inclusion => Rails.configuration.ofx[:meeting_type].keys
  validates :date, :presence => true
  validates :members, :presence => true
  validates :minutes, :presence => true
  validates :published, :inclusion => { in: [true, false] }

  
  def self.build_panel(type, num = 3)
    Minute.where(meeting: type, published: true).limit(num)
  end
    
end
