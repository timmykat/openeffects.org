class NewsItemsController < ApplicationController

  before_action :set_news_item, only: [:show, :edit, :update, :destroy]

  # GET /NewsItems
  def index
    @news_items = NewsItem.all
  end
  
  def show
  end

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    
    if @news_item.save
      redirect_to @news_item, notice: '#{@news_item.identifier} was successfully saved.'
    else
      render action: 'new'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to @news_item, notice: '#{@news_item.identifier} was successfully updated.'
    else
      render action: 'new'
    end
  end

  def destroy
    identifier = @news_item.identifier
    @news_item.destroy
    redirect_to news_items_url, notice: '#{name} was successfully deleted.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_item_params
      params[:news_item]
    end
end
