class Content < ActiveRecord::Base

  include ::HtmlSanitizer
  
  has_attached_file :image, :styles => { :listing => "50x50", :display => "200x200" }, :default_url => "images/:style/missing.png"
  has_attached_file :pdf, :styles => { :thumbnail => "50x50" }
   
  before_validation :sanitize_textareas
  validates :identifier, :presence => true, :length => { maximum: 50 }, :format => { with: /[a-z0-9_]/, message: "Please user lowercase alphanumeric and underscore (_) only" }
  validates :title, :presence => true
  validates :published, :inclusion => { in: [true, false] }
  
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]
  validates_attachment_content_type :pdf, :content_type => "application/pdf"
  validates_attachment_file_name :pdf, :matches => [/pdf\Z/]

  def self.build_panel(key)
    Content.where(identifier: key, published: true).first
  end
end


