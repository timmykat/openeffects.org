class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_admin 

  before_action :configure_permitted_parameters
  
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      flash.delete :recaptcha_error
      render :new
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :notifications)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :current_password, :notifications)
  end

  private :sign_up_params
  private :account_update_params  
  
  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :notifications) }
    end
end
