require 'rails_helper'

describe 'User' do
  describe 'submits a new comment form' do
    scenario 'and creates a new comment' do
      company = Company.create!(id: 2, name: "Dropbox")
      Category.create!(id: 1, title: "Developer")
      job = company.jobs.create!(title: "Game Dev", description: "Great job", level_of_interest: 60, city: "Albuquerque", category_id: 1)

      visit job_path(job)

      fill_in 'comment[content]', with: "This looks like a great position."

      click_button "Save"

      expect(current_path).to eq("/jobs/#{Job.last.id}")
      expect(page).to have_content("You added a new comment to #{job.title} at #{job.company.name}")
      expect(page).to have_content("This looks like a great position.")
    end
  end
end
