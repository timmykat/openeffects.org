class Company < ActiveRecord::Base

  include HtmlSanitizer

  belongs_to :contact, class_name: "User"
  has_attached_file :logo, :styles => { :listing => "100x100", :display => "200x200" }, :default_url => "images/:style/default_company.png"

  before_validation :sanitize_textareas
  validates :name, :presence => true
  validates :url, :presence => true, :format => { with: /\Ahttps?:\/\// }
  validates_attachment_content_type :logo, :content_type => /\Aimage/
  validates_attachment_file_name :logo, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]

  def self.build_panel
    {
      :use_logos => Company.all.pluck(:logo_file_name).inject(true) { |all, x| all and !x.blank? },
      :obj => Company.order(:name).to_a
    }
  end
  
end
