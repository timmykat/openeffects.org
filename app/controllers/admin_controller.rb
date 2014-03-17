class AdminController < ApplicationController

  def dashboard
    @minutes          = ::Minute.order("minutes.date DESC").to_a
    @news_items       = ::NewsItem.order(date: :desc).to_a
    @members_waiting  = ::User.where(approved: false).to_a
    @companies        = ::Company.order(:name).to_a
    @contents         = ::Content.order(:identifier).to_a
    @versions         = ::Version.order(version: :desc).to_a
    @home_heroes      = ::HomeHero.order(:active).to_a
    @links            = ::Link.all.to_a
  end
  
end
