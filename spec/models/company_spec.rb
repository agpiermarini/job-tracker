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

  describe 'class methods' do
    describe '.top_companies' do
      it 'returns the top three companies with average interest' do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        company_4 = Company.create!(id: 4, name: 'Stopbox')
        Category.create!(id: 1, title: "Developer")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 52, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 37, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 49, city: "Chicago", category_id: 1)
        job_4 = company_4.jobs.create!(title: "Job 4", description: "D", level_of_interest: 75, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 90, city: "Denver", category_id: 2)

        expected = [company_4, company_1, company_3]

        expect(Company.top_companies).to eq(expected)
      end
    end
  end
end
