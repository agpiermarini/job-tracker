class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category

  has_many :comments, dependent: :destroy

  def interest
    stars = (level_of_interest.to_f/20).ceil
    Array.new(stars, "*").join
  end

  def self.by_category(id, sort = "companies.name")
    joins(:company).where(category_id: id).order(sort)
  end

  def self.filter_by(filter, sort = 'companies.name')
    if filter[:city]
      joins(:company).where(city: filter[:city]).order(sort)
    elsif filter[:title]
      Category.find_by(title: filter[:title]).jobs.joins(:company).order(sort)
    elsif filter[:sort]
      sort_by(filter[:sort])
    end
  end

  def self.sort_by(sort)
    case sort
      when 'role'     then order('title')
      when 'interest' then order('level_of_interest DESC')
      when 'location' then order('city ASC')
      when 'company'  then joins(:company).order('companies.name')
      else joins(:company).order('companies.name')
    end
  end
end
