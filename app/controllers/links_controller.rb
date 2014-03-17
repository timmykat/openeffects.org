class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  def index
    @links = Link.all
    render 'admin/links'
  end
  
  def new
    @link = Link.new
  end
  
  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to admin_dashboard_path, notice: "#{@link.title} was successfully saved"
    else
      redirect_to admin_dashboard_path, alert: "#{@link.title} was not saved"
    end
  end
    
  def update
    if @link.update(link_params)
      redirect_to admin_dashboard_path, notice: "#{@link.title} was successfully updated"
    else
      redirect_to admin_dashboard_path, alert: "#{@link.title} was not properly updated"
    end
  end

  def destroy
    @link.destroy
    redirect_to admin_dashboard_path, notice: 'Link was deleted'
  end
  
  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params[:link].permit(:url, :title)
    end
end
