class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @job = Job.find(params[:job_id])
    if @job.comments.create(comment_params)
      flash[:success] = "Comment added to #{@job.title} at #{@job.company.name}"
      redirect_to job_path(params[:job_id])
    else
      flash[:failure] = "Failed to save comment"
      redirect_to job_path(params[:job_id])
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @comment = @job.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_to job_path(params[:job_id])
    else
      flash[:failure] = "Failed to delete comment"
      redirect_to job_path(params[:job_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
