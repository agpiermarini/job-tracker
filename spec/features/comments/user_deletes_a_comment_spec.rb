require 'rails_helper'

describe 'User' do
  describe 'clicks delete button form' do
    scenario 'it deletes the comment' do
      Category.create!(id: 1, title: "Developer")
      company = Company.create!(id: 2, name: "Dropbox")
      job = company.jobs.create!(id: 1, title: "Game Dev", description: "Great job", level_of_interest: 60, city: "Albuquerque", category_id: 1)
      comment_1 = job.comments.create(content: "Comment 1")

      visit job_path(job)

      find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click

      expect(current_path).to eq(job_path(job))
      expect(page).to_not have_content("Comment 1")
    end
  end
end


# <i class="far fa-trash-alt"></i>'.html_safe
