require 'rails_helper'

describe 'User visits categories index' do
  scenario 'a user sees all categories on a single page' do
    category_1 = Category.create!(title: "Category 1")
    category_2 = Category.create!(title: "Category 2")
    category_3 = Category.create!(title: "Category 3")
    category_4 = Category.create!(title: "Category 4")
    category_5 = Category.create!(title: "Category 5")

    visit categories_path

    expect(page).to have_content("Category 1")
    expect(page).to have_content("Category 2")
    expect(page).to have_content("Category 3")
    expect(page).to have_content("Category 4")
    expect(page).to have_content("Category 5")
  end

  scenario 'a user can navigate to individual categories' do
    category_1 = Category.create!(title: "Category 1")
    category_2 = Category.create!(title: "Category 2")

    visit categories_path

    click_link "Category 1"

    expect(current_path).to eq(category_path(category_1))
  end

  scenario 'a user can edit each category' do
    category_1 = Category.create!(title: "Category 1")

    visit categories_path

    find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click

    fill_in "category[title]", with: "New Category Name"
    click_button "Update"

    visit categories_path

    expect(page).to have_content("New Category Name")
    expect(page).to_not have_content("Category 1")
  end
end
