class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_admin 

  before_action :configure_permitted_parameters 
  
  def create
    if verify_recaptcha || ( user_signed_in? && (current_user.has_role? :admin) )
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      flash.delete :recaptcha_error
      render :new
    end
  end
  
  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    if (params[:user][:password] == Rails.configuration.ofx[:default_password])
      flash[:alert] = "That password is not allowed. Please change your password."
      redirect_to edit_user_registration_path(resource)
      return
    end
    
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end    

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :notifications, :approved)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :current_password, :notifications)
  end

  private :sign_up_params
  private :account_update_params  
  
  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :notifications, :approved) }
    end
end
