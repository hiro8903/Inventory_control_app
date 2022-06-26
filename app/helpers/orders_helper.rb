module OrdersHelper

  # 発注に対しての納期回答（Answer）の編集リンクを作成する。
  # def answer_link(order, answer, value)
  #   if value.present?
  #     link_to "#{value}", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-success"
  #   elsif answer.note.present?
  #     link_to "編集する", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-success"
  #   else
  #     link_to "未定", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-primary"
  #   end
  # end

  # def answer_link(order, answer, value)
  #   if value.present?
  #     # 注文に対する回答の総量
  #     total_answer_quantity = 0
  #     order.answers.each do |answer|
  #       total_answer_quantity += answer.quantity
  #     end
  #   end
  #     if value.present?
  #       link_to "#{value}", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-success"
  #     elsif answer.note.present?
  #       link_to "編集する", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-success"
  #     else
  #       link_to "未定", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-primary"
  #     end
      
  # end

    # 注文に対する回答の総量（発注に対する回答残があるか判断するのに使用する）
    def remaining_order(order, answers, answer_index, answer)
      if answers[answer_index] != nil?
        total_answer_quantity = 0
        order.answers.each do |answer|
          total_answer_quantity += answer.quantity
        end
        order.quantity - total_answer_quantity
      end
    end

  def answer_btn(order, answer_index)
    answer = order.answers.find(answer_index) if answer_index > 0
    
    if answer.present? && answer.answer_on.present?
      link_to "#{answer.answer_on}", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-primary"
    else
      link_to "未定", new_answer_path(order_id: order.id), class: "btn-sm btn-primary"
    end

  end

  # 発注に対する回答が来た際、その内容を登録するためのボタンまたは編集んのリンク
  def answer_link(order, answers, answer_index, answer)

    # 何番目の回答か判断する。
    answer = answers[answer_index]

    # 注文に対する回答の総量（発注に対する回答残があるか判断するのに使用する）
    if answers[answer_index] != nil?
      total_answer_quantity = 0
      order.answers.each do |answer|
        total_answer_quantity += answer.quantity
      end
    end
      # if answers[answer_index].present? && answers[answer_index].answer_on.nil?
      #   link_to "未定", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
      # elsif answers[answer_index] == answer && total_answer_quantity < order.quantity
      #   link_to "未定2", new_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
      # elsif answers[answer_index].present? && answers[answer_index].answer_on.present?
      #   link_to "#{answers[answer_index].answer_on}", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-success"
      # elsif answers[answer_index].present? && answers[answer_index].note.present?
      #   link_to "編集する", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-success"
      # end

      # 発注した際自動で設定される回答用のボタン（発注した際に回答がひとつ自動生成されるので編集ボタン）
      # または回答したが、回答数量が発注数量に満たない（注残がある場合）の回答用ボタン（新規）
      # if answers[answer_index].present?
        # if answers[answer_index].answer_on.nil?
        #   link_to "未定", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
        # end

    # 納品日が確定。

    if answer.present? && answer.answer_on.present? 
      link_to "#{answer.answer_on}", edit_answer_path(answer, order_id: order.id), class: "btn-sm btn-success"
    # 納品日未定の注残あり。
    elsif answer.blank?
      link_to "残#{order.quantity - total_answer_quantity}kg", new_answer_path(order_id: order.id), class: "btn-sm btn-primary"
    # 何の回答もなし。
    else 
      link_to "未定", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
    end



      # end

      
      # if answers[answer_index].present? && answers[answer_index].answer_on.nil?
      #   link_to "未定", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
      # elsif answers[answer_index] == answer && total_answer_quantity < order.quantity
      #   link_to "未定2", new_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-primary"
      # elsif answers[answer_index].present? && answers[answer_index].answer_on.present?
      #   link_to "#{answers[answer_index].answer_on}", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-success"
      # elsif answers[answer_index].present? && answers[answer_index].note.present?
      #   link_to "編集する", edit_answer_path(answers[answer_index], order_id: order.id), class: "btn-sm btn-success"
      # end

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
      link_to "#{remaining_order} #{order.paint.unit} 残", new_answer_path(order_id: order.id), class: "btn-sm btn-primary"
    end
  end

  def delivery_link(answer, value)
    if value.present?
      link_to "#{value}", edit_delivery_path(answer_id: answer.id)
    end
  end
  

  def remaining_derivery(order, answer)
    total_answer_quantity = 0
    order.answers.each do |answer|
      total_answer_quantity += answer.quantity if answer.quantity != nil
    end
    total_derivery_quantity = 0
    answer.deliverys.each do |delivery|
      total_derivery_quantity += delivery.quantity if delivery.quantity != nil
    end
      @remaining_derivery = answer.quantity - total_derivery_quantity
  end
  

  def button_to_deriver_the_remaining_answer(order, answer)
    total_derivery_quantity(order, answer)
    if @remaining_derivery != 0
      link_to "#{@remaining_derivery/1000} #{unit_conversion_to_1000_times(order.paint.unit.to_s)} 残", new_delivery_path(answer_id: answer.id),  class: "btn-sm btn-primary"
    end
  end
  
  def arrival_confirmer(delivery)
    User.find(delivery.arrival_confirmer_id)
  end

  def invoice_confirmer(delivery)
    unless delivery.invoice_confirmer_id.nil?
    User.find(delivery.invoice_confirmer_id)
    end
  end

  def order_table_row_count(order)
    answers = order.answers
    delivery_total_quantity = 0
    count = 0
    answers.each do |answer|
      count += answer.deliverys.count
      deliverys_quantity = 0
      answer.deliverys.each do |delivery|
        delivery_total_quantity += delivery.quantity
        deliverys_quantity += delivery.quantity
      end
      count += 1 if deliverys_quantity < answer.quantity 
    end
    order.quantity - delivery_total_quantity == 0 ? count : count + 1
  end

  # 一つの発注に対する納入予定回数（deliveryオブジェクト数）
  def delivery_times(order)
    answers = order.answers
    i = 0
    answers.each do |answer|
      i += answer.deliverys.count
    end
    # if i != 0
      return i
    # else i == 0
    #   return 1
    # end
  end

  # 発注一覧表の一つの発注に対する行数（deliveryオブジェクトが無い場合は＋１）
  def order_table_row_times(order)
    answers = order.answers
    total_answer_quantity = 0
    answers.each do |answer|
      total_answer_quantity += answer.quantity
    end
    if order.quantity > total_answer_quantity
      delivery_times(order) + 1
    else 
      delivery_times(order)
    end

    # return [answers.count, delivery_times(order)].max
  end

  # 一つの回答に対する納品の行数
  def answer_table_row_times(answer)
    deliverys = answer.deliverys
    total_deliverys_quantity = 0
    deliverys.each do |delivery|
      total_deliverys_quantity += delivery.quantity
    end
    delivery_times = answer.deliverys.count
    if answer.quantity > total_deliverys_quantity
      delivery_times + 1
    else
      delivery_times
    end
    # binding.pry
  end

  
  # ひとつの発注に対する回答の総数量（kg）
  def order_total_answers_quantity(order)
    answers = order.answers
    total_answers_quantity = 0
    answers.each do |answer|
      total_answers_quantity += answer.quantity
    end
    return total_answers_quantity
  end
  
  # ひとつの回答に対する納品の総数量（kg）
  def answer_total_deliverys_quatity(answer)
    deliverys = answer.deliverys
    total_deliverys_quantity = 0
    deliverys.each do |delivery|
      total_deliverys_quantity += delivery.quantity
    end
    return total_deliverys_quantity
  end
  
  def remaining_answer?(order)
    total_answers_quantity = 0
    order.answers.each do |answer|
      total_answers_quantity += answer.quantity
    end
    total_answers_quantity != order.quantity
  end

  def remaining_delivery?(answer)
    total_deliverys_quantity = 0
    answer.deliverys.each do |delivery|
      total_deliverys_quantity += delivery.quantity
    end
    total_deliverys_quantity != answer.quantity
  end

  def order_row(order)
    total_row = 0
    answer_total_quantity = 0
    delivery_total_quantity = 0
    order.answers.each do |answer|
      remaining_delivery?(answer) ? total_row += answer.deliverys.count + 1 : total_row += answer.deliverys.count
      answer_total_quantity += answer.quantity
    end
    (order.quantity > answer_total_quantity) && order.answers.count > 1 ? total_row += 1 : total_row
    return total_row
  end


  def delivery_link(answer, delivery)
    if delivery.delivery_on.blank?
      link_to "未入荷", edit_delivery_path(delivery, answer_id: answer.id), class: "btn-sm btn-primary"
    elsif delivery.delivery_on.present?
      link_to "#{delivery.delivery_on}", edit_delivery_path(delivery, answer_id: answer.id), class: "btn-sm btn-success"
    else
      link_to("残#{answer.quantity - answer_total_deliverys_quatity(answer)}", new_delivery_path(answer_id: answer.id))
    end
  end
  
end
