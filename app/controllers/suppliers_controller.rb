class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:success] = "#{@supplier.name}を仕入先に登録しました。"
      redirect_to suppliers_url
    else
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    initial_supplier_name = @supplier.name
    if @supplier.update_attributes(supplier_params)
      if @supplier.name != initial_supplier_name
        flash[:success] = "仕入先情報を更新しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to suppliers_url
    else
      render 'edit'
    end
  end

  def destroy
    supplier = Supplier.find(params[:id]).destroy
    flash[:success] = "#{supplier.name}を削除しました。"
    redirect_to suppliers_url
  end
  
  
private

  def supplier_params
    params.require(:supplier).permit(:name)
  end


end
