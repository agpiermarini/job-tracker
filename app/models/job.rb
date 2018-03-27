class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category


  def interest
    stars = (level_of_interest.to_f/20).ceil
    Array.new(stars, "*").join
  end

  def self.by_category(id, sort = "companies.name")
    joins(:company).where(category_id: id).order(sort)
  end

  def self.filter_by(sort_by, sort = "companies.name")
    if sort_by[:city]
      joins(:company).where(city: sort_by[:city]).order(sort)
    elsif sort_by[:title]
      joins(:category).where(title: sort_by[:title]).order(sort)
    end
  end
end
