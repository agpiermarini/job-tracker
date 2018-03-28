class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    elsif query_params
      @jobs = Job.filter_by(query_params)
    else
      @jobs = Job.all
    end
  end

  def new
    if params[:company_id]
      @company = Company.find(params[:company_id])
    else
      @companies = Company.all
    end
    @job = Job.new()
    @categories = Category.all
  end

  def create
    @company = Company.find(company_params)
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "Created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @job = Job.find(params[:id])
    @company = @job.company
    @categories = Category.by_name
  end

  def update
    @company = Company.find(company_params)
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      redirect_to company_job_path(@company, @job)
      flash[:success] = "Updated #{@job.title} at #{@company.name}"
    else
      flash[:failure] = "Failed to update #{@job.title} at #{@company.name}"
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    company = job.company
    if job.destroy
      flash[:success] = "Deleted #{job.title} at #{company.name}"
    else
      flash[:failure] = "Failed to delete #{job.title} at #{company.name}"
    end
      redirect_to company_jobs_path(company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :company_id, :category_id)
  end

  def company_params
    params[:company_id] ? params[:company_id] : job_params[:company_id]
  end

  def query_params
    if params[:location]
      { city: params[:location] }
    elsif params[:category]
      { title: params[:category] }
    elsif params[:sort]
      { sort: params[:sort] }
    end
  end
end
