require 'rails_helper'

describe 'User' do
  DatabaseCleaner.clean
  @company_one = Company.create!(name: "ESPN")
  @company_two = Company.create!(name: "Google")
  @category_one = Category.create!(title: "Media")
  @category_two = Category.create!(title: "Big Data")
  @job_one = @company_one.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver")
  @job_two = @company_one.jobs.create!(title: "Title 2", description: "This is Job 2", level_of_interest: 4, city: "Denver")
  @job_three = @company_two.jobs.create!(title: "Title 3", description: "This is Job 3", level_of_interest: 3, city: "LA")
  @job_four = @company_two.jobs.create!(title: "Title 4", description: "This is Job 4", level_of_interest: 2, city: "Chicago")

  context 'can filter jobs' do
    scenario 'by location' do
      visit jobs_path
      click_on 'location'

    end

    scenario 'by category' do

    end
  end

  context 'can sort jobs' do
    scenario 'by location' do

    end

    scenario 'by level of interest' do

    end

  end
end
