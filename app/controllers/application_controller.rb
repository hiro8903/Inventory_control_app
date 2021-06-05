class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_order
    @order = Order.find(params[:order_id])
  end
  
end
