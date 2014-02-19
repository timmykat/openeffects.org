module Publishable
  extend ActiveSupport::Concern
  
  def publish!
    self.published = true
  end
  
  def unpublish!
    self.published = false
  end

  def is_published?
    self.published
  end 
end