require 'rails_helper'

describe 'User visits page for a single category' do
  describe 'they visit a category\'s page' do
    it 'they see all jobs listed for that category' do
      company = Company.create!(name: "Google")
      category_1 = Category.create!(title: "User Experience")
      category_2 = Category.create!(title: "Software")
      job_1 = company.jobs.create(title: "User Experience Researcher I", level_of_interest: 5, city: "Boulder", category_id: category_1.id)
      job_2 = company.jobs.create(title: "User Experience Researcher II", level_of_interest: 5, city: "Boulder", category_id: category_1.id)
      job_3 = company.jobs.create(title: "Recruiter", level_of_interest: 5, city: "Boulder", category_id: category_1.id)
      job_4 = company.jobs.create(title: "Software Developer", level_of_interest: 5, city: "Boulder", category_id: category_2.id)

      visit category_path(category_1)

      expect(page).to have_content("User Experience Researcher I")
      expect(page).to have_content("User Experience Researcher II")
      expect(page).to have_content("Recruiter")
      expect(page).to_not have_content("Software Developer")
    end
  end
end
