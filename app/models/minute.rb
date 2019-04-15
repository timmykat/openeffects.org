class Minute < ActiveRecord::Base
  include FriendlyId
  friendly_id :meeting_type_and_date, :use => :slugged

  include Ofx::HtmlSanitizer
  
  before_validation :sanitize_textareas
  validates :meeting, :presence => true, :inclusion => Rails.configuration.ofx[:meeting_type].keys.map {|x| x.to_s}
  validates :date, :presence => true
  validates :members, :presence => true
  validates :minutes, :presence => true
  validates :published, :inclusion => { in: [true, false] }
  
  default_scope { order('date DESC') }

  
  def self.build_panel(type, num = 3)
    Minute.where(meeting: type, published: true).limit(num)
  end
  
  def meeting_type_and_date
    "#{:meeting} #{date}"
  end
    
end
