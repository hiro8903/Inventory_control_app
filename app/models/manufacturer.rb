class Manufacturer < ApplicationRecord
  has_many :paints
  has_many :suppliers, through: :paints
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
end
