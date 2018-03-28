require 'rails_helper'

describe "User deletes existing company" do
  scenario "a user can delete a company" do
    company = Company.create(name: "ESPN")
    visit companies_path

    find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click

    expect(page).to have_content("Deleted ESPN")
  end
end
