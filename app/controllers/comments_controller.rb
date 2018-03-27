class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @job = Job.find(params[:job_id])
    if @job.comments.create(comment_params)
      flash[:success] = "You added a new comment to #{@job.title} at #{@job.company.name}"
      redirect_to job_path(params[:job_id])
    else
      flash[:failure] = "Your comment was not saved"
      redirect_to job_path(params[:job_id])
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @comment = @job.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "You deleted a comment"
      redirect_to job_path(params[:job_id])
    else
      flash[:failure] = "Comment not deleted"
      redirect_to job_path(params[:job_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
