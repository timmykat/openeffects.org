class MinutesController < ApplicationController

  before_action :set_minutes, only: [:show, :edit, :update, :destroy]

  # GET /Minutes
  def index
    @minutes = Minutes.all
  end
  
  def show
  end

  def new
    @minutes = Minutes.new
  end

  def create
    @minutes = Minutes.new(minutes_params)
    
    if @minutes.save
      redirect_to @minutes, notice: '#{@minutes.identifier} was successfully saved.'
    else
      render action: 'new'
    end
  end

  def update
    if @minutes.update(minutes_params)
      redirect_to @minutes, notice: '#{@minutes.identifier} was successfully updated.'
    else
      render action: 'new'
    end
  end

  def destroy
    identifier = @minutes.identifier
    @minutes.destroy
    redirect_to minutes_url, notice: '#{name} was successfully deleted.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minutes
      @minutes = Minutes.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def minutes_params
      params[:minutes]
    end
end
