class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def jobs_by_category(category_id)
    jobs.where(category_id: category_id)
  end
end
