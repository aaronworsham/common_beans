class SellsController < ApplicationController
  respond_to :html, :json

  def create
    @sell = Sell.create(params[:sell].merge(:user => current_user))
    respond_with(@sell) 
  end

  def sell_url(x)
    "/sells"
  end
end
