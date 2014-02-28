module ApplicationHelper
  def get_admin_users
    User.where("roles_mask & ?", User.mask_for(:admin))
  end

  def get_version_status_selection
    Rails.configuration.ofx["version_status"].map { |k, v| [v, k] }
  end  
end
