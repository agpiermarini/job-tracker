require 'rails_helper'

describe 'User' do
  describe 'and clicks link to delete category'
    skip 'and it successfully deletes category' do
    category_1 = Category.create!(title: "Category 1")
    category_2 = Category.create!(title: "Category 2")
    category_3 = Category.create!(title: "Category 3")
    category_4 = Category.create!(title: "Category 4")
    category_5 = Category.create!(title: "Category 5")

    visit categories_path

    # Scope in and click delete?

    expect(current_path).to eq(category_path)
    expect(page).to_not have_content("Category 1")
  end
end
