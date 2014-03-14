class User < ActiveRecord::Base

  include FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  # Role functionality from the role_model gem
  include RoleModel
  roles_attribute :roles_mask

  # Do not change the order below! If more roles are added, ALWAYS APPEND them.
  roles :admin, :director, :user_admin
  
  # Include default devise modules. Others available are:
  # :lockable, :confirmable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, :presence => true, :uniqueness => true       
  validates :email, :presence => true, :uniqueness => true
  
  has_attached_file :avatar, :styles => { :listing => "50x50", :display => "200x200" }, :default_url => "images/:style/default_avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
  validates_attachment_file_name :avatar, :matches => [ /png\Z/, /jpe?g\Z/, /gif\Z/ ]
  
  has_one :company, :foreign_key => :contact_id
  has_many :comments
  has_many :standard_changes, :foreign_key => :last_editor_id
  has_many :standard_changes, :foreign_key => :sponsor_id
  
  after_create :send_admin_email
  
  def slug_candidates
    [
      :name,
      [:name, :created_at]
    ]
  end

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
    AdminMailer.new_user_waiting_for_approval.deliver
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
  
  # Find all users with a given role
  def self.method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ /^get_([a-z_]+)_users$/
      User.where("roles_mask & ?", User.mask_for($1.to_sym)).to_a
    else
      super
    end
  end

  def self.respond_to?(method_sym, include_private = false)
    if method_sym.to_s =~ /^get_([a-z_]+)_users$/
      true
    else
      super
    end
  end

  protected

    def password_required?
     !persisted? || !password.blank? || !password_confirmation.blank?
    end
end
