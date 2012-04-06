class StockSellsController < ApplicationController
  respond_to :html, :json

  def index
    @sells = current_user.stock_sells
    respond_with(@sells)
  end

  def show
    @sell = StockSell.find_by_id params[:id]
    respond_with(@sell)
  end

  def create
    @sell = StockSell.create(params[:stock_sell].merge(:user => current_user))
    if @sell.valid?
      respond_with(@sell)
    else
      log_errors @sell
    end
  end
  def destroy
    @sell = StockSell.find_by_id params[:id]
    @sell.destroy
    respond_with(@sell)
  end
end
