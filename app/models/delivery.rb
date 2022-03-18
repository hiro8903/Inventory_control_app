class Delivery < ApplicationRecord
  # belongs_to :user
  belongs_to :answer
  # belongs_to :order
  # with_options presence: true do
  #   # validates :delivery_on
  #   validates :quantity

  #   # validates :user_id
  # end
  validates :quantity, presence: true
  # validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0.5}
  validates :lot_number, length: { maximum: 20 }
end
