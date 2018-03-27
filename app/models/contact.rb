class Contact < ApplicationRecord
  validates_presence_of :name, :role, :email
  belongs_to :company
end
