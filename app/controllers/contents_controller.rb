class ContentsController < ApplicationController
  
  before_action :require_admin, except: [:page_display]
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /Contents
  def index
    @contents = Content.all
  end
  
  def show
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    
    if @content.save
      redirect_to @content, notice: "#{@content.identifier} was successfully saved."
    else
      render action: 'new'
    end
  end

  def update
    if @content.update(content_params)
      redirect_to @content, notice: "#{@content.identifier} was successfully updated."
    else
      render action: 'new'
    end
  end

  def destroy
    identifier = @content.identifier
    @content.destroy
    redirect_to contents_url, notice: '#{identifier} was successfully deleted.'
  end
  
  def page_display
    @content = Content.where(identifier: params[:ident]).first
  end
  
  private    
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_params
      params[:content].permit(:identifier, :title, :content, :image, :pdf, :pdf_title, :published)
    end

end
