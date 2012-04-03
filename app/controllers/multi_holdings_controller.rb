class MultiHoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.multi_holdings
    respond_with(@holdings)
  end

  def show
    @holding = MultiHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def create
    @holding = MultiHolding.create(params[:multi_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = MultiHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
