module ApplicationHelper
  def get_admin_users
    User.where("roles_mask & ?", User.mask_for(:admin))
  end
end
