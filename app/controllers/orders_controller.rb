class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @paints = Paint.all
  end

  def create
    @order = Order.new(order_params)
    @paints = Paint.all
    if @order.save
      flash[:success] = "登録しました。（ 塗料：#{@order.paint.name}　希望納期：#{@order.desired_on}　数量：#{@order.quantity}#{@order.paint.unit} ）"
      redirect_to orders_url
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
    @paints = Paint.all
  end

  def update
    @order = Order.find(params[:id])
    @paints = Paint.all
    # 変更前の発注情報を一時的に保存する（更新後の値と比較する為）
    initial_order_on = @order.order_on
    initial_paint_id = @order.paint_id
    intiial_quantity = @order.quantity
    initial_desired_on = @order.desired_on
    initial_note = @order.note
    if @order.update_attributes(order_params)
      if initial_order_on != @order.order_on \
        || initial_paint_id != @order.paint_id \
        || intiial_quantity != @order.quantity \
        || initial_desired_on != @order.desired_on \
        || initial_note != @order.note
        flash[:success] = "発注情報を変更しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to orders_url
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id]).destroy
    flash[:success] = "削除しました。（ 塗料：#{@order.paint.name}　希望納期：#{@order.desired_on}　数量：#{@order.quantity}#{@order.paint.unit} ）"
    redirect_to orders_url
  end
  
  
  private

    def order_params
      params.require(:order).permit(:order_on, :paint_id, :quantity, :desired_on, :note)
    end
    
end
