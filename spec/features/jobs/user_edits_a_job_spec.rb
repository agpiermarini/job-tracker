require 'rails_helper'

describe "User edits a job" do
  scenario "a user can edit a job" do
    category = Category.create(title: "Media")
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver", category_id: category.id)

    visit company_job_path(company, job)

    click_link "Edit"

    fill_in "job[title]", with: "New Title"
    fill_in "job[description]", with: "New Description"
    fill_in "job[level_of_interest]", with: 1
    fill_in "job[city]", with: "Colorado Springs"

    click_button "Update Job"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("New Title")
    expect(page).to have_content("New Description")
    expect(page).to have_content("1")
    expect(page).to have_content("Colorado Springs")
  end
end
