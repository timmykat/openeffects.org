class Company < ActiveRecord::Base
  belongs_to :contact, class_name: "User"
  validates :name, :presence => true
  validates :url, :format => { with: /\Ahttps?:\/\// }
  before_validation :sanitize_html

  has_attached_file :logo, :styles => { :listing => "50x50", :display => "200x200" }, :default_url => "images/:style/default_company.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage/
  validates_attachment_file_name :logo, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]

  def self.build_panel
    {
      :use_logos => Company.all.pluck(:logo_file_name).inject(true) { |all, x| all and !x.blank? },
      :obj => Company.order(:name).to_a
    }
  end
  
  private
    def sanitize_html
      self.description = Sanitize.clean(self.description, Sanitize::Config::RELAXED.merge({
        :attributes => 
          {
            :all => ['class'],
            'a' => ['title', 'target', 'href']
          }
        }))
    end

end
