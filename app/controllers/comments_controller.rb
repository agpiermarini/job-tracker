class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    binding.pry
    @job = Job.find(params[:job_id])
    @comment = @job.comments.create(comment_params)
    flash[:success] = "You added a new comment to #{@job.title} at #{@job.company.name}"
    redirect_to job_path(params[:job_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
