class Paint < ApplicationRecord
  belongs_to :manufacturer, foreign_key: "manufacturer_id"
  belongs_to :supplier, foreign_key: "supplier_id"
  validates :name,  presence: true, length: { maximum: 50 }
  with_options presence: true do
    validates :manufacturer_id
    validates :supplier_id
    validates :unit_price
    validates :unit
  end
end
