class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    
  private
    def require_admin
      unless current_user and current_user.has_role? :admin
        flash[:alert] = "You must be an admin to do that!"
        begin
          redirect_to :back
        rescue ActionController::RedirectBackError
          redirect_to :root
        end
      end
    end    
end
