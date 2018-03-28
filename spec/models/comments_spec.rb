require 'rails_helper'

describe Comment do
  describe "validations" do
    it {is_expected.to validate_presence_of(:content)}
  end

  describe "relationships" do
    it {is_expected.to belong_to(:job)}
  end

  describe "class methods" do
    describe ".by_date" do
      it 'sorts comments from most recent to oldest' do
        category_1 = Category.create(title: "Category 1")
        company_1 = Company.create(name: "Turing")
        job_1 = company_1.jobs.create(title: "Developer", description: "Awesome", level_of_interest: 99, city: "Denver", category_id: 1)
        comment_1 = job_1.comments.create(content: "This is the oldest comment")
        comment_2 = job_1.comments.create(content: "This is neither the newest nor the oldest comment")
        comment_3 = job_1.comments.create(content: "This is the newest comment")

        expect(Comment.by_date.first).to eq(comment_3)
      end
    end
  end
end
