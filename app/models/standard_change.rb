class StandardChange < ActiveRecord::Base
  include FriendlyId
  friendly_id :title, :use => :slugged
  
  include Ofx::HtmlSanitizer

  belongs_to :version
  belongs_to :sponsor, class_name: "User"
  belongs_to :last_editor, class_name: User
  
  acts_as_commentable
  has_many :comments, dependent: :destroy, as: :commentable
  
  scope :current, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :recent_first, -> { includes(:version).order("versions.version DESC, standard_changes.status ASC, standard_changes.title ASC") }
  
  before_validation :sanitize_textareas
  validates :title, presence: true, length: { maximum: 100 }
  validates :type, inclusion: { in: Rails.configuration.ofx[:standard_change_type].keys.map{ |k| k.to_s }, message: 'is not a valid change type' }
  validates :status, inclusion: { in: Rails.configuration.ofx[:standard_change_status].keys.map{ |k| k.to_s }, message: 'is not a valid status' }

  # Because of Rails' penchant for single-table inheritance (:type would ordinarily indicate a subclass in this case),
  # we need to specify that there is no inheritance column
  
  self.inheritance_column = nil

  after_save :notify_subscribers
  
  # Notify subscribers when a standard change is updated.
  def notify_subscribers
    AdminMailer.notify_of_standard_change(self)
  end
  
  def self.build_panel(change_status, limit = 3)
    StandardChange.current.where(status: 'proposed').order("created_at DESC", "title ASC").limit(limit)
  end

  def saved_by(current_user)
    self.last_editor_id = current_user.id
    self.save
  end
  
  def updated_by(standard_change_params, current_user)
    self.last_editor_id = current_user.id
    self.update(standard_change_params)
  end
end
