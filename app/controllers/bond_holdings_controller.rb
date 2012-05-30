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

  def edit
    @holding = BondHolding.find_by_id params[:id]
    render :template => 'edit_securities/bond/edit_bond', :layout => false
  end
  def update
     params[:bond_holding][:purchased_at] = Date.strptime(params[:bond_holding][:purchased_at], '%m/%d/%Y')
     @holding = BondHolding.find_by_id params[:id]
     @holding.update_attributes(params[:bond_holding].except(:id))
     puts @holding.errors.full_messages
     render :json => {:success => true}

  end
  def create
    params[:bond_holding][:purchased_at] = Date.strptime(params[:bond_holding][:purchased_at], '%m/%d/%Y')
    @holding = BondHolding.create(params[:bond_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = BondHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
