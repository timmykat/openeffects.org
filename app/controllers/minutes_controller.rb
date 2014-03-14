class MinutesController < ApplicationController

  before_action :set_minutes, only: [:show, :edit, :update, :destroy]
  
  def toggle_published
    m = Minute.friendly.find(params[:id])
    m.toggle(:published)
    m.save
    render :text => m.published? ? 'published' : ''
  end
  
  # GET /Minutes
  def index
    @minutes = Minute.all
  end
  
  def show
    @minute = Minute.friendly.find(params[:id])
  end

  def new
    @minute = Minute.new
  end

  def create
    @minute = Minute.new(minutes_params)
    
    if @minute.save
      redirect_to @minute, notice: "#{@minute.meeting} for #{@minute.date}  was successfully saved."
    else
      render action: 'new'
    end
  end

  def edit
    @minute = Minute.friendly.find(params[:id])
  end

  def update
    if @minute.update(minutes_params)
      redirect_to @minute, notice: "#{@minute.meeting} for #{@minute.date} was successfully updated."
    else
      render action: 'new'
    end
  end

  def destroy
    name = "#{@minute.meeting.upcase} meeting for #{@minute.date.strftime('%Y')}"
    @minute.destroy
    redirect_to minutes_url, notice: "#{name} was successfully deleted."
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minutes
      @minute = Minute.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def minutes_params
      params[:minute].permit(:meeting, :date, :location, :members, :observing, :minutes, :published)
    end
end
