class Department < ApplicationRecord
  has_many :users
  # reactions_nested_attributes_for :user_department
  validates :name,  presence: true, length: { maximum: 20 }, uniqueness: true
end
