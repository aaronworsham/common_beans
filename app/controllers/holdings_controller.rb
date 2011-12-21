class HoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.holdings
    respond_with(@holdings)
  end

  def show
    @holding = StockHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def create
    @holding = StockHolding.create(params[:holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = StockHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
