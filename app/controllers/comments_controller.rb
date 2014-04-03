class CommentsController < ApplicationController

  before_action :set_comment, only: [:update, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to standard_change_path(@comment.commentable), notice: "Your comment was successfully saved."
    else
      redirect_to standard_change_path(@comment.commentable)
    end
  end
  
  # Called from ajaxy inline-editable
  def update
    @comment.update(comment_params)
    respond_to do |format| 
      format.json { render :json => { :status => :ok } }
      format.html { render :html => @comment.comment}
    end
  end

  def destroy
    standard_change = @comment.commentable
    @comment.destroy
    respond_to do |format| 
      format.json { render :json => { :status => :ok } }
      format.html { redirect_to standard_change_path, notice: 'The comment was successfully deleted.' }
    end
  end

  private
    def check_role
      unless current_user.has_role? :admin
        flash[:alert] = "You must have adminstrative access to view this."
        redirect_to root
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params[:comment].permit(:id, :title, :comment, :user_id, :commentable_id, :commentable_type)
    end
end
