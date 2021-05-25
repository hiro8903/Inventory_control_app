class PaintsController < ApplicationController

  require 'nkf'

  def index
    @paints = Paint.all
  end

  def new
    @paint = Paint.new
    @manufacturers = Manufacturer.all
    @suppliers = Supplier.all
  end

  def create
    @paints = Paint.all
    @paint = Paint.new(paint_params)
    @manufacturers = Manufacturer.all
    @suppliers = Supplier.all
    if @paint.save
      # debugger
      flash[:success] = "#{@paint.name}を登録しました。"
      redirect_to paints_url
    else
      render 'new'
    end
  end
  
  def edit
    @paint = Paint.find(params[:id])
    @manufacturers = Manufacturer.all
    @suppliers = Supplier.all
  end


  def update
    @paint = Paint.find(params[:id])
    @manufacturers = Manufacturer.all
    @suppliers = Supplier.all
    # 変更前の塗料データを一時的に保存する（更新後の値と比較する為）
    initial_name = @paint.name
    initial_manufacturer_id = @paint.manufacturer_id
    intiial_supplier_id = @paint.supplier_id
    initial_unit_price = @paint.unit_price
    initial_unit = @paint.unit
    initial_ordering_point = @paint.ordering_point
    if @paint.update_attributes(paint_params)
      # 塗料名をフォーマットする（平仮名はカタカナに、全角英数は半角英数に変換）
      @paint.name = NKF.nkf('-w -Z1 -h2 -X', paint_params[:name])
      @paint.save
      # 送信されたデータに変更があるか確認する。
      if initial_name != @paint.name \
        || initial_manufacturer_id != @paint.manufacturer_id \
        || intiial_supplier_id != @paint.supplier_id \
        || initial_unit_price != @paint.unit_price \
        || initial_unit != @paint.unit \
        || initial_ordering_point != @paint.ordering_point
        flash[:success] = "塗料情報を更新しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to paints_url
    else
      render 'edit'
    end
  end

  private

    def paint_params
      params.require(:paint).permit(:name, :manufacturer_id, :supplier_id, :unit_price, :unit, :ordering_point)
    end
    
end
