class SessionsController < Devise::SessionsController
  skip_before_action :require_admin 
  
  # If the password is the default, go to the edit user screen
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    
    if (params[:user][:password] == Rails.configuration.ofx[:default_password])
      flash[:alert] = "Please change your password."
      redirect_to edit_user_registration_path(resource)
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end  
end

