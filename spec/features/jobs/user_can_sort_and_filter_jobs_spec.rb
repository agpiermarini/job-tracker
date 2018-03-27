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
  end

  context 'can filter jobs' do
    scenario 'by location' do
      visit '/jobs?location=Denver'

      expect(page).to have_content(@job_one.title)
      expect(page).to have_content(@job_two.title)
      expect(page).to_not have_content(@job_three.title)
      expect(page).to_not have_content(@job_four.title)
    end

    scenario 'by category' do
      visit '/jobs?category=Developer'

      expect(page).to have_content(@job_one.title)
      expect(page).to have_content(@job_two.title)
      expect(page).to have_content(@job_three.title)
      expect(page).to_not have_content(@job_four.title)
    end
  end

  context 'can sort jobs' do
    scenario 'by location ascending' do
      visit jobs_path
      click_on 'Location'

      within ('table tr:nth-child(1) td:nth-child(3)') do
        expect(page).to have_content @job_four.title
      end
    end

    scenario 'by level of interest descending' do
      visit jobs_path
      click_on 'Interest'

      within ('table tr:nth-child(1) td:nth-child(3)') do
        expect(page).to have_content @job_one.title
      end
    end

    scenario 'by role ascending' do
      visit jobs_path
      click_on 'Role'

      within ('table tr:nth-child(1) td:nth-child(3)') do
        expect(page).to have_content @job_one.title
      end
    end

    scenario 'by company ascending' do
      visit jobs_path
      click_on 'Company'

      within ('table tr:nth-child(1) td:nth-child(3)') do
        expect(page).to have_content @job_one.title
      end
    end
  end
end
