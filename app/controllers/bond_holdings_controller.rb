class BondHoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.holdings
    respond_with(@holdings)
  end

  def show
    @holding = BondHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def create
    @holding = BondHolding.create(params[:bond_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = BondHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
