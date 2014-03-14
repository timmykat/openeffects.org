class NewsItemsController < ApplicationController

  before_action :set_news_item, only: [:show, :edit, :update, :destroy]

  # GET /NewsItems
  def index
    @news_items = NewsItem.all
  end
  
  def show
    @news_item = NewsItem.friendly.find(params[:id])
  end

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    
    if @news_item.save
      redirect_to @news_item, notice: "#{@news_item.headline} was successfully saved."
    else
      render action: 'new'
    end
  end
  
  def edit
    @news_item = NewsItem.friendly.find(params[:id])
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to @news_item, notice: "#{@news_item.headline} was successfully updated."
    else
      render action: 'new'
    end
  end

  def destroy
    headline = @news_item.headline
    @news_item.destroy
    redirect_to news_items_url, notice: '#{headline} was successfully deleted.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_item_params
      params[:news_item].permit(:headline, :date, :summary, :published)
    end
end
