class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_admin, only: [:edit, :update, :destroy]
  
  private
    def require_admin
      unless current_user and current_user.has_role? :admin
    end
end
