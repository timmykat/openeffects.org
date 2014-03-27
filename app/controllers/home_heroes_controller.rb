class HomeHeroesController < ApplicationController
  before_action :check_role

  def create_and_update
    msg = []
    
    unless params[:home_hero][:hero_image].blank?
      params[:home_hero].delete(:id)
      params[:home_hero] = params[:home_hero].merge({ :active => true })
      hh = HomeHero.new(home_hero_params)
      unless hh.save
        msg << "There was a problem saving the hero image"
      end
    else
      HomeHero.update_all("active = 0")
      hh = HomeHero.find(home_hero_params[:id])
      unless hh.update(active:true)
        msg << "There was a problem updating #{hh.hero_image.filename}"
      else
        hh.create_assets
      end
      
      unless home_hero_params[:delete].blank?
        home_hero_params[:delete].each do |id|
          hh = HomeHero.find(id.to_i)
          hh.destroy
          msg << "Hero deleted"
        end
      end
    end
    flash[:notice] = msg.join("\n") unless msg.blank?
    redirect_to admin_dashboard_path 
  end
  
  private
    def check_role
      unless current_user.has_role? :admin
        flash[:alert] = "You must have adminstrative access to view this."
        redirect_to root
      end
    end

    # Only allow a trusted parameter "white list" through.
    def home_hero_params
      params.require(:home_hero).permit(:id, :hero_image, :active, delete: [])
    end

end