class HomeHero < ActiveRecord::Base
  has_attached_file :hero_image, :styles => { :list_display => "400x400", :xs => "768x768", :sm => "992x992", :md => "1200x1200", :lg => "1600x1600" }
  validates :hero_image, presence: true 
  validates_attachment_content_type :hero_image, :content_type => /\Aimage/
  validates_attachment_file_name :hero_image, :matches => [ /png\Z/, /jpe?g\Z/ ]
  
  after_save :create_assets
  
  # Moves the assets into the public assets directory - home here is always referred to as 'hero'
  def create_assets
    self.hero_image.styles.each do |key,style|
      width = (/(\d+)x/.match(style.geometry))[1]
      type = (/\.(jpg|png|gif)/.match(style.attachment.to_s))[1]
      public_hero = File.join(Rails.root, 'public', 'assets', "hero_#{width}.#{type}")
      source_image = File.join(Rails.root,'public',self.hero_image(key).gsub(/\?.*$/,''))
      %x( cp #{source_image} #{public_hero} )
    end
  end
end
