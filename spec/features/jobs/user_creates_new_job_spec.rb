require 'rails_helper'

describe "User" do
  context "can create a job from the company path" do
    scenario "it saves the new job" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Media")
      visit new_company_job_path(company)

      expect(page).to have_content("Create a New Job at #{company.name}")

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"
      select "Media", from: "job[category_id]"

      click_button "Create"

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
      expect(page).to have_content("ESPN")
      expect(page).to have_content("Developer")
      expect(page).to have_content("80")
      expect(page).to have_content("Denver")
    end


    skip "user cannot create job without selecting category" do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Media")
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Anchor"
      fill_in "job[description]", with: "Talk to cameras"
      fill_in "job[level_of_interest]", with: 3
      fill_in "job[city]", with: "Denver"

      click_button "Create Job"

      expect(page).to have_content("Please select an item in the list.")
    end
  end

  context 'can create a job from the jobs path' do
    scenario 'it saves the new job' do
      company = Company.create!(name: "ESPN")
      category = Category.create!(title: "Media")
      visit new_job_path

      expect(page).to_not have_content('Create a New Job at')

      fill_in "job[title]", with: "Developer"
      fill_in "job[description]", with: "So fun!"
      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"
      select "Media", from: "job[category_id]"
      select "ESPN", from: 'job[company_id]'

      click_button "Create"

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
      expect(page).to have_content("ESPN")
      expect(page).to have_content("Developer")
      expect(page).to have_content("80")
      expect(page).to have_content("Denver")
    end
  end
end
