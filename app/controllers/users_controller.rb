class UsersController < ApplicationController
  skip_before_action :require_admin, except: [:new_by_admin]
  before_action :require_admin_or_self, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # Work outside devise for admin-created new users because it does session checking
  def new_by_admin
    @user = User.new(user_params)
    @user.approved = true
    @user.password = Rails.configuration.ofx[:default_password]
    @user.password_confirmation = Rails.configuration.ofx[:default_password]
    if @user.save 
      AdminMailer.notify_of_new_account(@user)     
      redirect_to users_path, notice: "The new user was successfully created, and a notification email was sent to #{@user.email}."
    else
      redirect_to users_path, alert: "There was a problem creating the user."
    end
  end

  # AJAX methods
  def toggle
    u = User.friendly.find(params[:id])
    case params[:value]
      when 'approved'
        u.toggle(:approved)
        u.save
        ret = u.approved? ? 'approved' : ''
      when 'role'
        role = params[:role].to_sym
        if u.has_role? role
          u.roles.delete(role)
          ret = nil
        else 
          u.roles << role
          ret = 'added'
        end
        u.save    
    end
    render :text => ret
  end

  # RESTful methods
  # GET /Users
  def index
    @users = User.all
    @roles = User.valid_roles
  end
  
  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.name} was successfully updated."
    else
      render action: 'new'
    end
  end

  def destroy
    name = @user.name
    @user.destroy
    Rails.cache.clear
    redirect_to users_url, notice: "#{name} was successfully deleted."
  end
  
  private
    # Require that only the user or an admin can only perform these actions on himself
    def require_admin_or_self
      unless user_signed_in? and (current_user.has_role? :admin or current_user.id == params[:id])
        flash[:alert] = "I'm sorry, you don't have the privileges to do that."
        redirect_to root_path
      end 
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params[:user].permit(:email, :password, :password_confirmation, :name, :avatar, :approved, :company_or_org)
    end
end
