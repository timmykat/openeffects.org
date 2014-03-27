class UsersController < ApplicationController
  skip_before_action :require_admin
  before_action :require_admin_or_self, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # AJAX methods
  def toggle_approved
    u = User.friendly.find(params[:id])
    u.toggle(:approved)
    u.save
    render :text => u.approved? ? 'approved' : ''
  end

  def toggle_role
    u = User.friendly.find(params[:id])
    role = params[:role].to_sym
    if u.has_role? role
      u.roles.delete(role)
      ret = nil
    else 
      u.roles << role
      ret = 'added'
    end
    u.save
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
    redirect_to users_url, notice: '#{name} was successfully deleted.'
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
