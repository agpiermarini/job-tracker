require 'rails_helper'

describe 'User' do
  before(:each) do
    @company_one = Company.create!(name: "ESPN")
    @company_two = Company.create!(name: "Google")
    @category_one = Category.create!(title: "Developer")
    @category_two = Category.create!(title: "Media")
    @job_one = @company_one.jobs.create!(title: "Title 1", description: "This is Job 1", level_of_interest: 5, city: "Denver", category_id: @category_one.id)
    @job_two = @company_one.jobs.create!(title: "Title 2", description: "This is Job 2", level_of_interest: 4, city: "Denver", category_id: @category_one.id)
    @job_three = @company_two.jobs.create!(title: "Title 3", description: "This is Job 3", level_of_interest: 3, city: "LA", category_id: @category_one.id)
    @job_four = @company_two.jobs.create!(title: "Title 4", description: "This is Job 4", level_of_interest: 2, city: "Chicago", category_id: @category_two.id)
    @job_five = @company_two.jobs.create!(title: "Title 5", description: "This is Job 5", level_of_interest: 4, city: "Chicago", category_id: @category_two.id)
    @job_six = @company_two.jobs.create!(title: "Title 6", description: "This is Job 6", level_of_interest: 2, city: "Detroit", category_id: @category_two.id)
    @job_seven = @company_two.jobs.create!(title: "Title 4", description: "This is Job 7", level_of_interest: 2, city: "Chicago", category_id: @category_two.id)
  end

  context 'sees jobs by interest info on dashboard' do
    scenario 'interests are ranked descending with job counts' do
      visit dashboard_path

      expect(page).to have_content 'Jobs by Interest'
    end
  end

  context 'sees top companies by interest on dashboard' do
    scenario 'the top three companies are displayed' do
      visit dashboard_path

      expect(page).to have_content(@company_one.name)
      expect(page).to have_content(@company_two.name)
      within '.first-place' do
        expect(page).to have_content(@company_one.name)
      end
    end
  end

  context 'sees a list of locations' do
    scenario 'the locations have job counts' do
      visit dashboard_path

      Job.all.each do |job|
        expect(page).to have_content(job.city)
      end
    end

    scenario 'the location names are links' do
      visit dashboard_path
      click_on 'Denver jobs'

      expect(current_path).to eq('/jobs?location=Denver')

      visit dashboard_path
      click_on 'Chicago jobs'

      expect(current_path).to eq('/jobs?location=Chicago')
    end
  end
end
