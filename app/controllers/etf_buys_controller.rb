class EtfBuysController < ApplicationController
  respond_to :html, :json

  def index
    @buys = current_user.etf_buys
    respond_with(@buys)
  end

  def show
    @buy = EtfBuy.find_by_id params[:id]
    respond_with(@buy)
  end

  def create
    @buy = EtfBuy.create(params[:etf_buy].merge(:user => current_user))
    if @buy.valid?
      respond_with(@buy)
    else
      log_errors @buy
    end
  end
  def destroy
    @buy = EtfBuy.find_by_id params[:id]
    @buy.destroy
    respond_with(@buy)
  end
end
