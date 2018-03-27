class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
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
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @company = Company.find(company_params)
    @job = Job.find(params[:id])
    @categories = Category.by_name
  end

  def update
    @company = Company.find(company_params)
    @job = Job.find(params[:id])
    @job.update(job_params)
    if @job.save
      flash[:success] = "You edited #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:company_id])
    job = Job.find(params[:id])
    job.destroy
    flash[:success] = "#{job.title} was successfully deleted!"

    redirect_to company_jobs_path(company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :company_id, :category_id)
  end

  def company_params
    params[:company_id] ? params[:company_id] : job_params[:company_id]
  end
end
