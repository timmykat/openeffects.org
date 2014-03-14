class VersionsController < ApplicationController

  before_action :check_role
  before_action :set_version, only: [:edit, :update, :destroy]

  def new
    @version = Version.new
  end

  def edit
    @version = Version.find(params[:id])
  end

  def create
    current_version = Version.where(current: true)
    @version = Version.new(version_params)
    if @version.save    
      # If we are setting this new version to current, the old current version shouldn't be
      if @version.current?
        current_version.current = false
        current_version.save
      end
      redirect_to admin_dashboard_path, notice: "#{@version.version} was successfully saved."
    else
      redirect_to admin_dashboard_path
    end
  end

  def update
    current_version = Version.where(current: true)
    if @version.update(version_params)
      # If we are updating this version to current, the old current version shouldn't be
      if @version.current?
        current_version.current = false
        current_version.save
      end
      redirect_to versions_url, notice: "#{@version.version} was successfully updated."
    else
      redirect_to admin_dashboard_path
    end
  end

  def destroy
    version = @version.version
    @version.destroy
    redirect_to admin_dashboard_path, notice: '#{version} was successfully deleted.'
  end
  
  private
    def check_role
      unless current_user.has_role? :admin
        flash[:alert} = "You must have adminstrative access to view this."
        redirect_to root
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def version_params
      params[:version].permit(:version, :status, :current, :committee)
    end

end
