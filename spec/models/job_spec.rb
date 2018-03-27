require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, and company" do
        company = Company.new(name: "Turing")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
  end

  describe "class methods" do
    describe ".by_category" do
      it "returns jobs matching a category id" do
        company = Company.create!(id: 1, name: "Dropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company.jobs.create!(title: "Job 1", description: "Job 1", level_of_interest: 1, city: "Job 1", category_id: 1)
        job_2 = company.jobs.create!(title: "Job 2", description: "Job 2", level_of_interest: 1, city: "Job 2", category_id: 1)
        job_3 = company.jobs.create!(title: "Job 3", description: "Job 3", level_of_interest: 1, city: "Job 3", category_id: 1)
        job_4 = company.jobs.create!(title: "Job 4", description: "Job 4", level_of_interest: 1, city: "Job 4", category_id: 2)

        expect(company.jobs.size).to eq(4)
        expect(Job.by_category(1).size).to eq(3)
      end
    end
  end
end
