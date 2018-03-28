class DashboardController < ApplicationController
  def show
    @interest_scale = Job.jobs_by_interest
    @top_companies = Company.top_companies
    @locations = Job.locations
  end
end
