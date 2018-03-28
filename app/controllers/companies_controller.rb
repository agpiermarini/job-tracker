class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    company = Company.new(company_params)
    if company.save
      flash[:success] = "Created a company named #{company.name}"
      redirect_to company_path(company)
    else
      flash[:alert] = "Failed to create a new company"
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
    @contact = Contact.new
    @contacts = @company.contacts
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    company = Company.find(params[:id])
    if company.update(company_params)
      flash[:success] = "Updated #{company.name}"
      redirect_to company_path(company)
    else
      flash[:alert] = "Failed to update #{company.name}"
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:id])
    if company.destroy
      flash[:success] = "Deleted #{company.name}"
    else
      flash[:alert] = "Failed to delete #{company.name}"
    end
    redirect_to companies_path
  end


  private

  def company_params
    params.require(:company).permit(:name, :city)
  end
end
