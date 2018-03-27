class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  has_many :comments

  def interest
    stars = (level_of_interest.to_f/20).ceil
    Array.new(stars, "*").join
  end

  def self.by_category(id, sort = "companies.name")
    joins(:company).where(category_id: id).order(sort)
  end
end
