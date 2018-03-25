require 'rails_helper'

describe Category do
  describe "validations" do
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_uniqueness_of(:title)}
  end

  describe "relationships" do
    it {is_expected.to have_many(:jobs)}
  end

  describe "class methods" do
    describe ".by_name" do
      it "sorts categories by title" do
        category_1 = Category.create!(id: 1, title: "Zebra")
        category_2 = Category.create!(id: 2, title: "Alligator")
        category_3 = Category.create!(id: 3, title: "Giraffe")

        unsorted = Category.all
        sorted = Category.by_name

        expect(unsorted.first.title).to eq("Zebra")
        expect(unsorted.last.title).to eq("Giraffe")
        expect(sorted.first.title).to eq("Alligator")
        expect(sorted.last.title).to eq("Zebra")
      end
    end
  end
end
