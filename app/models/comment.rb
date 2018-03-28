class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :job

  def self.by_date
    order(created_at: :desc)
  end
end
