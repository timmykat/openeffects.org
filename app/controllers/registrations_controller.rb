class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_admin 

  before_action :configure_permitted_parameters

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar, :current_password)
  end

  private :sign_up_params
  private :account_update_params  
  
  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :company_or_org, :avatar) }
    end
end
