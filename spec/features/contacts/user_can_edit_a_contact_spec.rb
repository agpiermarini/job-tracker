require 'rails_helper'

describe 'User' do
  context 'from /company/:id' do
    scenario 'can edit a contact' do
      company = Company.create!(name: "ESPN")
      contact = company.contacts.create(name: 'Tim',
                                        role: 'Manager',
                                        email: 'tom@company.com')

      visit company_path(company)

      expect(page).to have_content(contact.name)

      find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click

      expect(page).to have_content(contact.name)
    end
  end

  context 'from /company/:id/contacts/edit' do
    scenario 'can update a contact' do
      company = Company.create!(name: "ESPN")
      contact = company.contacts.create(name: 'Tim',
                                        role: 'Manager',
                                        email: 'tom@company.com')

      visit edit_company_contact_path(company, contact)

      expect(page).to have_content(contact.name)

      fill_in 'contact[name]', with: 'Ted'
      click_on 'Save'

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('Ted')
    end
  end
end
