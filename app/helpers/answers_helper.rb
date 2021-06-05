module AnswersHelper
  
  # 回答可能な最大納品数量（注文残の数量）を計算する。
  def max_quantity(remaining_quantity, answer_quantity)
    return answer_quantity + remaining_quantity
  end
  
end
