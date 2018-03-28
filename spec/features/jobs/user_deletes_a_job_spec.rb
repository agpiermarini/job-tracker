require 'rails_helper'

describe 'User deletes a job' do
  scenario 'a user can delete a job' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "Software")
    job = company.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver", category_id: category.id)

    visit company_job_path(company, job)

    find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click

    expect(page).to have_content("Deleted #{job.title}")
    expect(current_path).to eq(company_jobs_path(company))
  end
end
