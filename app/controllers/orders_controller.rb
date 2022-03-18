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
      @answer = @order.answers.build(quantity: 0)
      @answer.save
      @delivery = @answer.deliverys.build(quantity: 0)
      # @delivery = @answer.deliverys.build(quantity: 0)
      # @answer.save
      @delivery.save
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
    total_answer_quantity = 0
    @order.answers.each do |answer|
      total_answer_quantity += answer.quantity
    end
    if @order.update_attributes(order_params)
      # 変更後の数量が回答済みの納品予定数量より少ない場合は回答・納品情報をリセットする
      if @order.quantity < total_answer_quantity
        @order.answers.each do |answer|
          answer.destroy
        end
        @answer = @order.answers.build(quantity: 0)

        @answer.save
        @delivery = @answer.deliverys.build(quantity: 0)
        # @delivery = @answer.deliverys.build(quantity: 0)
        # @answer.save
        @delivery.save

      end
      if initial_order_on != @order.order_on \
        || initial_paint_id != @order.paint_id \
        || intiial_quantity != @order.quantity \
        || initial_desired_on != @order.desired_on 
        flash[:success] = "発注情報を変更しました。"
        if @order.answers.count == 0
          @answer = @order.answers.build(quantity: 0)

          @answer.save
          @delivery = @answer.deliverys.build(quantity: 0)
          # @delivery = @answer.deliverys.build(quantity: 0)
          # @answer.save
          @delivery.save
        end
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to orders_url
    else
      render 'edit'
    end
  end

  # 仕入先受付の有無（reactionチェックボックス）をまとめて更新。
  def update_reaction
    initial_orders = Order.all
      ActiveRecord::Base.transaction do # トランザクションを開始します。
        count = 0
        order_reaction_params.each do |id, item|
          @order = Order.find(id)
          initial_reaction = @order.reaction
          @order.update_attributes!(item)
          count += 1 if initial_reaction != @order.reaction
          
          # debugger
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
    
    # 仕入先受付の有無（update_reaction）用のパラメータ
    def order_reaction_params
      params.permit(:orders, orders: [:reaction])[:orders]
    end

    def delivery_invoice_params
      params.permit(:orders, orders: [:invoice])[:orders]
    end
    


    
end


# {"1"=><ActionController::Parameters {"reaction"=>"1"} permitted: false>


  # # 仕入先受付の有無（reactionチェックボックス）をまとめて更新。
  # def update_reaction
  #   initial_orders = Order.all
  #     ActiveRecord::Base.transaction do # トランザクションを開始します。
  #       count = 0
  #       order_reaction_params.each do |id, item|
  #         @order = Order.find(id)
  #         initial_reaction = @order.reaction
  #         @order.update_attributes!(item)
  #         count += 1 if initial_reaction != @order.reaction
          
  #         # debugger
  #       end
  #       invoice_count = 0
  #       delivery_invoice_params.each do |id, item|

  #         @delivery = Delivery.find(id) if Delivery.find(id) != nil
  #         initial_invoice = @delivery.invoice
  #         @delivery.update_attributes!(item)
  #         invoice_count += 1 if initial_invoice != @delivery.invoice
  #       end
  #       if count == 0 && invoice_count == 0
  #         flash[:warning] = "変更はありません。"
  #       else
  #         flash[:success] = "返信の有無を#{count}件更新, 請求書の確認を#{invoice_count}件更新。"
  #       end
  #       redirect_to orders_url
  #     end
  # rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
  #     flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  #       if @order.errors.any?
  #         @order.errors.full_messages.each do |msg| 
  #         flash[:danger] = "#{msg}"
  #         end 
  #       end
  #     redirect_to orders_url
  # end
