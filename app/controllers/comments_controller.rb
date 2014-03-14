class CommentsController < ApplicationController

  before_action :set_comment, only: [:destroy]
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to standard_change_path(@comment.commentable), notice: "Your comment was successfully saved."
    else
      redirect_to standard_change_path(@comment.commentable)
    end
  end

  def destroy
    standard_change = @comment.commentable
    @comment.destroy
    redirect_to standard_change_path, notice: 'The comment was successfully deleted.'
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
      params[:comment].permit(:title, :comment, :user_id, :commentable_id, :commentable_type)
    end
end
