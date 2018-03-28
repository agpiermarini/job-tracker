class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category

  has_many :comments, dependent: :destroy

  def interest
    stars = scale_of_five
    Array.new(stars, "*").join
  end

  def scale_of_five
    (level_of_interest.to_f/20).ceil
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
      when 'city'     then order('city ASC')
      when 'company'  then joins(:company).order('companies.name')
      else joins(:company).order('companies.name')
    end
  end

  def self.jobs_by_interest
    scale = group('level_of_interest / 20').order('level_of_interest_20 DESC').count
    scale[1] += scale.delete(0) if scale[0]
    scale
  end

  def self.locations
    group(:city).count
  end
end
