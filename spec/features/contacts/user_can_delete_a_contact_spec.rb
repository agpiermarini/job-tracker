require 'rails_helper'

describe 'User' do
  context 'from /company/:id' do
    scenario 'can delete a contact' do
      company = Company.create!(name: "ESPN")
      contact = company.contacts.create(name: 'Tim',
                                        role: 'Manager',
                                        email: 'tom@company.com')

      visit company_path(company)

      expect(page).to have_content(contact.name)

      find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click

      within('table') do
        expect(page).to_not have_content(contact.name)
      end
    end
  end
end
