require 'rails_helper'

describe 'when user is on a company show page' do
  context 'clicking on add contact' do
    scenario 'should create a new contact on company page' do
      company = Company.create!(name: 'Test Company')
      visit company_path(company)

      fill_in 'contact[name]', with: 'Tom'
      fill_in 'contact[role]', with: 'Manager'
      fill_in 'contact[email]', with: 'tom@company.com'
      click_button 'Save'

      expect(current_path).to eq('/companies/:id')
      within '.contacts-list' do
        expect(page).to have_content('Tom')
        expect(page).to have_content('Manager')
        expect(page).to have_content('tom@company.com')
      end
    end
  end
end
