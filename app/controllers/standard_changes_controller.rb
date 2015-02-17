class StandardChangesController < ApplicationController
  before_action :set_standard_change, only: [:show, :edit, :update, :destroy]


  def archive
    @standard_change = StandardChange.find(params[:id])
    if @standard_change.update_attribute(:archived, params[:archived])
      render :json => { status: 'ok' }
    else
      render :json => { status: 'error' }
    end
  end  
  
  # GET /standard_changes
  def index
    if params[:archived]
      @standard_changes = StandardChange.archived.recent_first
      @archived = true 
    else
      @standard_changes = StandardChange.current.recent_first
      @archived = false 
    end
  end

  # GET /standard_changes/1
  def show
    @comment = @standard_change.comments.new
    @comments = @standard_change.comments.recent
  end

  # GET /standard_changes/new
  def new
    @standard_change = StandardChange.new
  end

  # GET /standard_changes/1/edit
  def edit
  end

  # POST /standard_changes
  def create
    @standard_change = StandardChange.new(standard_change_params)

    if @standard_change.saved_by(current_user)
      redirect_to @standard_change, notice: 'Standard change was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /standard_changes/1
  def update
    if @standard_change.updated_by(standard_change_params, current_user)
      redirect_to @standard_change, notice: 'Standard change was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /standard_changes/1
  def destroy
    @standard_change.destroy
    redirect_to standard_changes_url, notice: 'Standard change was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_change
      @standard_change = StandardChange.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def standard_change_params
      params.require(:standard_change).permit(:version_id, :committee, :title, :type, :status, :status_details, :overview, :solution, :discussion, :archived)
    end
end
