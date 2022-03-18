class DeliveriesController < ApplicationController
  
  def new
    @answer = Answer.find(params[:answer_id])
    @delivery = @answer.deliverys.build
    @users = User.all
    @delivery_total_quantity = 0.0
    @answer.deliverys.each do |delivery|
      @delivery_total_quantity += delivery.quantity if delivery.quantity.present?
    end
    @remaining_quantity = @answer.quantity - @delivery_total_quantity
  end

  def create
    @users = User.all
    @answer = Answer.find(params[:answer_id])
    @delivery = @answer.deliverys.build(delivery_params)
    if @delivery.save
      flash[:success] = "入荷を登録しました。"
      redirect_to orders_url
    else
      if @delivery.errors.any?
        @delivery.errors.full_messages.each do |msg| 
        flash[:danger] = "#{msg}"
        end 
      end
      # @order = @answer.order
      render 'new'
    end
  end
  

  def edit
 
    @users = User.all
    @delivery = Delivery.find(params[:id])
    @answer = @delivery.answer
    @delivery_total_quantity = 0.0
    @answer.deliverys.each do |delivery|
      @delivery_total_quantity += delivery.quantity
    end
    @remaining_quantity = @answer.quantity - @delivery_total_quantity + @delivery.quantity
  end

  def update
    @users = User.all
    @delivery = Delivery.find(params[:id])
    @answer = @delivery.answer
    if @delivery.update_attributes(delivery_params)
      flash[:success] = "入荷情報を編集しました。"
      redirect_to orders_url
    else
      render 'edit'
    end
  end
  
  def destroy
    @delivery =Delivery.find(params[:id]).destroy
    flash[:success] = "入荷情報を削除しました。（ 塗料：#{@delivery.answer.order.paint.name}　納入日：#{@delivery.delivery_on}　数量：#{@delivery.quantity}#{@delivery.answer.order.paint.unit} ）"
    redirect_to orders_url
  end

  def update_invoice
    debugger
  end
  
  
  private

    def delivery_params
      params.require(:delivery).permit(:delivery_on, :quantity, :lot_number, :arrival_confirmer_id, :invoice_confirmer_id)
    end
    
end
