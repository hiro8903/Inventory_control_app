class OrdersController < ApplicationController
  protect_from_forgery

  def index
    @orders = Order.paginate(page: params[:page], per_page: 15).order(order_on: :DESC).joins(:paint).order("paints.name ASC")
    # @orders = Order.all.order(order_on: :DESC).joins(:paint).order("paints.name ASC")
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
    if @order.update_attributes(order_params)
      if initial_order_on != @order.order_on \
        || initial_paint_id != @order.paint_id \
        || intiial_quantity != @order.quantity \
        || initial_desired_on != @order.desired_on 
        flash[:success] = "発注情報を変更しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to orders_url
    else
      render 'edit'
    end
  end

  # 仕入先受付の有無（acceptチェックボックス）をまとめて更新。
  def update_accept
    initial_orders = Order.all
      ActiveRecord::Base.transaction do # トランザクションを開始します。
        count = 0
        order_accept_params.each do |id, item|
          @order = Order.find(id)
          initial_accept = @order.accept
          @order.update_attributes!(item)
          count += 1 if initial_accept != @order.accept
        end
        if count == 0
          flash[:warning] = "変更はありません。"
        else
          flash[:success] = "返信の有無を#{count}件更新しました。"
        end
        redirect_to orders_url
      end
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
        if @order.errors.any?
          @order.errors.full_messages.each do |msg| 
          flash[:danger] = "#{msg}"
          end 
        end
      redirect_to orders_url
  end
  

  def destroy
    @order = Order.find(params[:id]).destroy
    flash[:success] = "削除しました。（ 塗料：#{@order.paint.name}　希望納期：#{@order.desired_on}　数量：#{@order.quantity}#{@order.paint.unit} ）"
    redirect_to orders_url
  end
  
  private

    # 発注の登録・編集（create・update）用のパラメータ
    def order_params
      params.require(:order).permit(:order_on, :paint_id, :quantity, :desired_on)
    end
    
    # 仕入先受付の有無（update_accept）用のパラメータ
    def order_accept_params
      params.permit(:orders, orders: [:accept])[:orders]
    end
    
end
