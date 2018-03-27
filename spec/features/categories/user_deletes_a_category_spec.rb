require 'rails_helper'

describe 'User' do
  describe 'clicks link to delete category' do
    it 'and it successfully deletes category' do
      category_1 = Category.create!(id: 2, title: "Category 2")

      visit categories_path

      find(:xpath, ".//a[i[contains(@class, 'far fa-trash-alt')]]").click

      expect(current_path).to eq(categories_path)
      expect(page).to have_content("Category 2 deleted")
    end
  end
end
