class User < ActiveRecord::Base

  # Role functionality from the role_model gem
  include RoleModel
  roles_attribute :roles_mask

  # Do not change the order below! If more roles are added, ALWAYS APPEND them.
  roles :admin, :director
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
         
  validates :email, :presence => true
  
  has_attached_file :avatar, :styles => { :listing => "50x50", :display => "200x200" }, :default_url => "images/:style/default_avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
  validates_attachment_file_name :avatar, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]
  
  has_one :company, :foreign_key => :contact_id
  has_many :comments
  
#  after_create :send_admin_email

  # Handle user administration (approval by admin)
  def active_for_authentication?
    super && approved?
  end
  
  # Set the message depending on whether the user is approved or not
  def inactive_message
    if !approved?
      :not_approved
    else
      super
    end
  end
  
  # Send notification to the admin
  def send_admin_email
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end
  
  # Reset password instructions
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  protected

    def password_required?
     !persisted? || !password.blank? || !password_confirmation.blank?
    end
end
