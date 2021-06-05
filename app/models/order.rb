class Order < ApplicationRecord
  belongs_to :paint
  has_many :answers, dependent: :destroy
  with_options presence: true do
    validates :order_on
    validates :quantity
  end
end
