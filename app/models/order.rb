class Order < ApplicationRecord
  belongs_to :paint
  with_options presence: true do
    validates :order_on
    validates :quantity
  end
end
