module OrdersHelper

  # 発注に対しての納期回答（Answer）の編集リンクを作成する。
  def answer_link(order, answer, value)
    if value.present?
      link_to "#{value}", edit_answer_path(answer, order_id: order.id)
    else
      link_to "編集する", edit_answer_path(answer, order_id: order.id)
    end
  end

  # 納期回答が注文数に達しているか確認し、
  # 注文残がある時は回答用のボタンを表示させる。
  def button_to_answer_the_remaining_order(order)
    total_answer_quantity = 0
    order.answers.each do |answer|
      total_answer_quantity += answer.quantity if answer.quantity != nil
    end
    remaining_order = order.quantity - total_answer_quantity
    if remaining_order != 0
    link_to "残：#{remaining_order/1000} #{unit_conversion_to_1000_times(order.paint.unit.to_s)}", new_answer_path(order_id: order.id),  class: " btn-sm btn-primary"
    end
  end

end
