require 'rails_helper'

describe 'User visits page for a single category' do
  describe 'they visit a category\'s page' do
    it 'they see all jobs listed for that category' do
      company = Company.create!(name: "Google")
      category = Category.create!(title: "User Experience")
      job_1 = company.jobs.create(title: "User Experience Researcher I", level_of_interest: 5, city: "Boulder", category_id: category.id)
      job_2 = company.jobs.create(title: "User Experience Researcher II", level_of_interest: 5, city: "Boulder", category_id: category.id)
      job_1 = company.jobs.create(title: "Recruiter", level_of_interest: 5, city: "Boulder", category_id: category.id)

      visit category_path(category)

      expect(page).to have_content("User Experience Researcher I")
      expect(page).to have_content("User Experience Researcher II")
      expect(page).to have_content("Recruiter")
    end
  end
end
