class Supplier < ApplicationRecord
  has_many :paints
  has_many :manufacturers, through: :paints
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
end
