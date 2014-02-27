class AdminController < ApplicationController

  def dashboard
    @minutes = ::Minute.order("minutes.date DESC").to_a
    @news_items = ::NewsItem.order(date: :desc).to_a
    @members_waiting = ::User.where(approved: false).to_a
    @companies = ::Company.order(:name).to_a
    @contents = ::Content.order(:identifier).to_a
  end
  
  def get_api_docs
    
    
    
  end
    
end
