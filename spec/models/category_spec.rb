require 'rails_helper'

describe Category do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        category = Category.new
        expect(category).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title" do
        category = Category.new(title: "Software")
        expect(category).to be_valid
      end
    end
  end
end



  # describe "relationships" do
  #   it "belongs to a company" do
  #     job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
  #     expect(job).to respond_to(:company)
  #   end
  # end
