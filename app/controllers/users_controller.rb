class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # AJAX methods
  def toggle_approved
    u = User.find(params[:id])
    u.toggle(:approved)
    u.save
    render :text => u.approved? ? 'approved' : ''
  end

  def toggle_role
    u = User.find(params[:id])
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
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user, notice: "#{@user.name} was successfully saved."
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params[:user].permit(:email, :password, :password_confirmation, :name, :avatar, :approved)
    end
end
