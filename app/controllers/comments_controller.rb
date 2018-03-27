class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    binding.pry
    @comment = Comment.create(params[:comment])
    flash[:success] = "You added a new comment to #{@job.title} at #{@job.company.name}"
    redirect_to job_path(params[:id])
  end
end
