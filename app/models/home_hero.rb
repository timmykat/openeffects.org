class HomeHero < ActiveRecord::Base
  has_attached_file :hero_image, :styles => { :xs => "768x768", :sm => "992x992", :md => "1200x1200", :lg => "1600x1600" }, :default_url => "images/:style/default_company.png"
  validates :hero_image, presence: true, 
  validates_attachment_content_type :hero_image, :content_type => /\Aimage/
  validates_attachment_file_name :hero_image, :matches => [ /png\Z/, /jpe?g\Z/ ]
end
