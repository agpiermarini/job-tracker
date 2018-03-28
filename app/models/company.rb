class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def jobs_by_category(category_id)
    jobs.where(category_id: category_id)
  end

  def self.top_companies
    thing = select('companies.*, avg(jobs.level_of_interest) AS average_interest')
      .joins(:jobs)
      .group(:id)
      .order('average_interest DESC')
      .first(3)
  end
end
