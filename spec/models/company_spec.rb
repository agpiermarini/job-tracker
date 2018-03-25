require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end

  describe "instance methods" do
    describe ".jobs_by_category" do
      it "returns all jobs matching a category_id" do
        company = Company.create!(id: 1, name: "Dropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = Job.create!(title: "Job 1", description: "Job 1", level_of_interest: 1, city: "Job 1", company_id: 1, category_id: 1)
        job_2 = Job.create!(title: "Job 2", description: "Job 2", level_of_interest: 1, city: "Job 2", company_id: 1, category_id: 1)
        job_3 = Job.create!(title: "Job 3", description: "Job 3", level_of_interest: 1, city: "Job 3", company_id: 1, category_id: 1)
        job_4 = Job.create!(title: "Job 4", description: "Job 4", level_of_interest: 1, city: "Job 4", company_id: 1, category_id: 2)

        expect(company.jobs_by_category(1).size).to eq(3)
        expect(company.jobs.size).to eq(4)
      end
    end
  end
end
