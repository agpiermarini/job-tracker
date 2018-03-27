class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company

  def self.by_category(id)
    joins(:company).where(category_id: id).order("companies.name")
  end
end
