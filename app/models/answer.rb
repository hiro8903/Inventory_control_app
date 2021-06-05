class Answer < ApplicationRecord
  belongs_to :order
  validates :quantity,  presence: true
  validate :quantity_over_the_order_balance_is_invalid

  def quantity_over_the_order_balance_is_invalid
    if quantity != nil
      total_answer_quantity = 0
      order.answers.each do |answer|
        total_answer_quantity += answer.quantity unless answer.quantity == nil 
      end
      remaining_order = order.quantity - total_answer_quantity + quantity
      errors.add(:quantity, "は注文残量（#{remaining_order}）以内の数値を入力してください。") if order.quantity < total_answer_quantity
    end
  end 
  
end
