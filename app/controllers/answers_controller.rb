class AnswersController < ApplicationController
  before_action :set_order, only:[:new, :create, :edit]

  def new
    @answer = @order.answers.build
    @answer_total_quantity = 0
    @order.answers.each do |answer|
      @answer_total_quantity += answer.quantity if answer.quantity.present?
    end
    @remaining_quantity = @order.quantity - @answer_total_quantity
  end

  def show
    redirect_to edit_answer_url
  end

  def create
    @answer = @order.answers.build(answer_params)
    if @answer.save
      @answer.deliverys.build(quantity: 0).save if @answer.deliverys.count == 0
      flash[:success] = "納期回答を登録しました。"
      redirect_to orders_url
    else
      if @answer.errors.any?
        @answer.errors.full_messages.each do |msg| 
        flash[:danger] = "#{msg}"
        end 
      end
      @order = @answer.order
      render 'new'
    end
  end
  
  def edit
    @answer =Answer.find(params[:id])
    @answer_total_quantity = 0
    @order.answers.each do |answer|
      @answer_total_quantity += answer.quantity if answer.quantity.present?
    end
    @remaining_quantity = @order.quantity - @answer_total_quantity
  end

  def update
    @answer = Answer.find(params[:id])
    @order = @answer.order
    # 変更前の回答情報を一時的に保存する（更新後の値と比較する為）
    initial_answer_on = @answer.answer_on
    initial_quantity = @answer.quantity
    intiial_note = @answer.note
    @answer_total_quantity = 0
    @order.answers.each do |answer|
      @answer_total_quantity += answer.quantity if answer.quantity.present?
    end
    @remaining_quantity = @order.quantity - @answer_total_quantity
    if @answer.update_attributes(answer_params)

      if initial_answer_on != @answer.answer_on \
        || initial_quantity != @answer.quantity \
        || intiial_note != @answer.note
        flash[:success] = "回答情報を変更しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to orders_url
    else
      redirect_to edit_answer_url(@answer, order_id: @order.id)
      # render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id]).destroy
    flash[:success] = "納期回答を削除しました。（ 塗料：#{@answer.order.paint.name}　納期回答：#{@answer.answer_on}　数量：#{@answer.quantity}#{@answer.order.paint.unit} ）"
    redirect_to orders_url
  end
  

private

  def answer_params
    params.require(:answer).permit(:answer_on, :quantity, :note, :order_id)
  end
  
  # # 新規回答登録（create）時に注文数量より多い数量を登録不可にする。
  # def quantity_over_the_order_balance_is_invalid(answer)
  #   if answer.quantity != nil
  #     @total_answer_quantity = 0
  #     @order.answers.each do |answer|
  #       @total_answer_quantity += answer.quantity unless answer.quantity == nil 
  #     end
  #     @remaining_order = @order.quantity - @total_answer_quantity + answer.quantity
  #     answer.errors.add(:quantity, "は注文残量（#{@remaining_order}）以内の数値を入力してください。") if @order.quantity < @total_answer_quantity
  #     answer.errors.full_messages.each do |msg| 
  #       flash[:danger] = "#{msg}"
  #       end 
  #   end
  # end 

end
