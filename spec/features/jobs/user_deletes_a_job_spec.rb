require 'rails_helper'

describe 'User deletes a job' do
  scenario 'a user can delete a job' do
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver")

    visit company_job_path(company, job)

    click_link "Delete"

    expect(page).to have_content("#{job.title} was successfully deleted")
    expect(current_path).to eq(company_jobs_path(company))
  end
end
