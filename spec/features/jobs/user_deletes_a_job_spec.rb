require 'rails_helper'

describe 'User deletes a job' do
  scenario 'a user can delete a job' do
    company = Company.create!(name: "ESPN")
    job_1 = company.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver")
    job_2 = company.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver")

    visit company_job_path(company, job_2)

    click_link "Delete"

    expect(current_path).to eq(company_path(company))
    expect(page).to_not have_content(job_1.title)
    expect(page).to have_content(job_2.title)
  end
end
