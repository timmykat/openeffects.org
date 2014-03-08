class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include Ofx::HtmlSanitizer

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: Comments belong to a user
  belongs_to :user

  before_validation :sanitize_textareas
  validates :comment, :presence => true 
end
