class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /Users
  def index
    @users = User.all
  end
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user, notice: "#{@user.identifier} was successfully saved."
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.identifier} was successfully updated."
    else
      render action: 'new'
    end
  end

  def destroy
    identifier = @user.identifier
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
      params[:user]
    end
end
