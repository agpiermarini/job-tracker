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
        category = Category.create!(title: "Software")
        company = Company.new(name: "Turing")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
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

  describe "instance methods" do
    describe "#interest" do
      it "returns level_of_interest translated to asterisks on a scale of 1 asterisk to 5" do
        company = Company.create!(id: 1, name: "Dropbox")
        category = Category.create!(id: 1, title: "Test_Category_1")
        job_1 = company.jobs.create!(title: "Job 1", description: "Job 1", level_of_interest: 1, city: "Job 1", category_id: category.id)
        job_2 = company.jobs.create!(title: "Job 2", description: "Job 2", level_of_interest: 65, city: "Job 2", category_id: category.id)
        job_3 = company.jobs.create!(title: "Job 3", description: "Job 3", level_of_interest: 90, city: "Job 3", category_id: category.id)

        expect(job_1.interest).to eq("*")
        expect(job_2.interest).to eq("****")
        expect(job_3.interest).to eq("*****")
      end
    end
  end

  describe "class methods" do
    describe ".by_category with no sort parameter" do
      it "returns jobs matching a category id sorted by company name" do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 5, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 4, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 3, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 2, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 1, city: "El Paso", category_id: 2)

        expect(Job.all.size).to eq(5)
        expect(Job.by_category(1).size).to eq(3)
        expect(Job.by_category(1).first).to eq(job_3)
      end
    end

    describe ".by_category with city parameter" do
      it "returns jobs matching a category id sorted by city" do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 5, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 4, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 3, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 2, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 1, city: "El Paso", category_id: 2)

        expect(Job.all.size).to eq(5)
        expect(Job.by_category(1, "city").size).to eq(3)
        expect(Job.by_category(1, "city").first).to eq(job_1)
      end
    end

    describe ".by_category with interest parameter" do
      it "returns jobs matching a category id sorted by interest" do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 5, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 4, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 3, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 2, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 1, city: "El Paso", category_id: 1)

        expect(Job.all.size).to eq(5)
        expect(Job.by_category(1, "level_of_interest").size).to eq(4)
        expect(Job.by_category(1, "level_of_interest").first).to eq(job_5)
      end
    end

    describe ".filter_by with city parameter" do
      it "returns jobs in a city sorted by company" do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Test_Category_1")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 5, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 4, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 3, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 2, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 1, city: "Denver", category_id: 1)

        expect(Job.all.size).to eq(5)
        expect(Job.filter_by({ city: 'Denver' }, "companies.name").size).to eq(2)
        expect(Job.filter_by({ city: 'Denver' }, "companies.name").first).to eq(job_4)
      end
    end

    describe ".filter_by with category parameter" do
      it "returns jobs matching a category name sorted by company" do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Developer")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 5, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 4, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 3, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 2, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 1, city: "Denver", category_id: 2)

        expect(Job.all.size).to eq(5)
        expect(Job.filter_by({ title: 'Developer' }, "companies.name").size).to eq(3)
        expect(Job.filter_by({ title: 'Developer' }, "companies.name").first).to eq(job_3)
      end
    end

    describe '.jobs_by_interest' do
      it 'returns the count of jobs at each level on a of scale 1-5' do
        company_1 = Company.create!(id: 1, name: "Propbox")
        company_2 = Company.create!(id: 2, name: "Dropbox")
        company_3 = Company.create!(id: 3, name: "Cropbox")
        Category.create!(id: 1, title: "Developer")
        Category.create!(id: 2, title: "Test_Category_2")
        job_1 = company_1.jobs.create!(title: "Job 1", description: "A", level_of_interest: 52, city: "Albuquerque", category_id: 1)
        job_2 = company_2.jobs.create!(title: "Job 2", description: "B", level_of_interest: 37, city: "Boston", category_id: 1)
        job_3 = company_3.jobs.create!(title: "Job 3", description: "C", level_of_interest: 49, city: "Chicago", category_id: 1)
        job_4 = company_1.jobs.create!(title: "Job 4", description: "D", level_of_interest: 75, city: "Denver", category_id: 2)
        job_5 = company_1.jobs.create!(title: "Job 5", description: "E", level_of_interest: 90, city: "Denver", category_id: 2)

        expected = { 5 => 1, 4 => 1, 3 => 1, 2 => 2, 1 => 0 }

        expect(Job.jobs_by_interest).to eq expected
      end
    end
  end
end
