class SellsController < ApplicationController
  respond_to :html, :json

  def create
    @sell = Sell.create(params[:event].merge(:user => current_user))
    respond_with(@sell) 
  end

  def destroy
    @sell = sell.find_by_id params[:id]
    @sell.destroy
    respond_with(@sell)
  end

  def sell_url(x)
    "/sells"
  end
end
