class HomeHeroesController < ApplicationController
  before_action :check_role
  before_action :set_home_hero, only: [:show, :edit, :update, :destroy]

  def create_and_update
    params[:home_heroes].each do |k, home_hero_params|
      id = /\d+/.match(k).to_s.to_i
      if id == 0
        binding.pry
        @home_hero = HomeHero.new(home_hero_params)
        unless @home_hero.save
          flash[:alert] = "There was a problem saving the hero image"
        end
      else
        hh = HomeHero.find(id)
        unless hh.update(home_hero_params)
          flash[:alert] = "There was a problem updating #{hh.hero_image.filename}"
        end
      end
      redirect_to admin_dashboard_path 
    end
  end
  
  # GET /home_heros
  def index
    @home_heros = HomeHero.all
  end

  # GET /home_heros/1
  def show
  end

  # GET /home_heros/new
  def new
    @home_hero = HomeHero.new
  end

  # GET /home_heros/1/edit
  def edit
  end

  # POST /home_heros
  def create
    @home_hero = HomeHero.new(home_hero_params)

    if @home_hero.save
      redirect_to @home_hero, notice: 'Home hero was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /home_heros/1
  def update
    if @home_hero.update(home_hero_params)
      redirect_to @home_hero, notice: 'Home hero was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /home_heros/1
  def destroy
    @home_hero.destroy
    redirect_to home_heros_url, notice: 'Home hero was successfully destroyed.'
  end

  private
    def check_role
      unless current_user.has_role? :admin
        flash[:alert] = "You must have adminstrative access to view this."
        redirect_to root
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_home_hero
      @home_hero = HomeHero.find(params[:id]) unless params[:id] == 0
    end

    # Only allow a trusted parameter "white list" through.
    def home_hero_params
      params.require(:home_hero).permit(:active, :hero_image)
    end
end
