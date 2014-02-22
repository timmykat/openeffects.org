class Content < ActiveRecord::Base
  include Publishable
  
  has_attached_file :image, :styles => { :listing => "50x50", :display => "200x200" }, :default_url => "images/:style/missing.png"
  has_attached_file :pdf, :styles => { :thumbnail => "50x50" }
   
  validates :identifier, :presence => true, :length => { maximum: 50 }, :format => { with: /[a-z0-9_]/, message: "Please user lowercase alphanumeric and underscore (_) only" }
  validates :title, :presence => true
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]
  validates_attachment_content_type :pdf, :content_type => "application/pdf"
  validates_attachment_file_name :pdf, :matches => [/pdf\Z/]
  before_validation :sanitize_html

  def self.build_panel(key)
    Content.where(identifier: key).first
  end

  private
    def sanitize_html
      self.content = Sanitize.clean(self.content, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
            'a' => ['title', 'target', 'href']
          }
        }))
    end
end
