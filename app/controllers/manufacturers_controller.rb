class ManufacturersController < ApplicationController

  def index
    @manufacturers = Manufacturer.all
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:success] = "#{@manufacturer.name}を登録しました。"
      redirect_to manufacturers_url
    else
      render 'new'
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    initial_dapartment_name = @manufacturer.name
    if @manufacturer.update_attributes(manufacturer_params)
      if @manufacturer.name != initial_dapartment_name
        flash[:success] = "メーカー情報を更新しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to manufacturers_url
    else
      render 'edit'
    end
  end

  def destroy
    manufacturer = Manufacturer.find(params[:id]).destroy
    flash[:success] = "#{manufacturer.name}を削除しました。"
    redirect_to manufacturers_url
  end

  private

    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end
    
  
end
