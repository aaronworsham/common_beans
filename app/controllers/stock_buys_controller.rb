class StockBuysController < ApplicationController
  respond_to :html, :json

  def index
    @buys = current_user.stock_buys
    respond_with(@buys)
  end

  def show
    @buy = StockBuy.find_by_id params[:id]
    respond_with(@buy)
  end

  def create
    @buy = StockBuy.create(params[:stock_buy].merge(:user => current_user))
    if @buy.valid?
      respond_with(@buy)
    else
      log_errors @buy
    end
  end
  def destroy
    @buy = StockBuy.find_by_id params[:id]
    @buy.destroy
    respond_with(@buy)
  end
end
