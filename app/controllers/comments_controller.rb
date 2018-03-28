class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added to #{@job.title} at #{@job.company.name}"
      redirect_to job_path(params[:job_id])
    else
      flash[:alert] = "Failed to save comment"
      redirect_to job_path(params[:job_id])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_to job_path(params[:job_id])
    else
      flash[:alert] = "Failed to delete comment"
      redirect_to job_path(params[:job_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
