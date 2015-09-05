class AdminController < ApplicationController

  before_action :require_admin, :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
    
  def dashboard
    @minutes          = ::Minute.order("minutes.date DESC").to_a
    @news_items       = ::NewsItem.order(date: :desc).to_a
    @members_waiting  = ::User.where(approved: false).to_a
    @companies        = ::Company.order(:name).to_a
    @contents         = ::Content.order(:identifier).to_a
    @versions         = ::Version.order(version: :desc).to_a
    @home_heroes      = ::HomeHero.order(active: :desc).to_a
    @links            = ::Link.all.to_a
  end
  
end
