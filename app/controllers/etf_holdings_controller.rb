class EtfHoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.holdings
    respond_with(@holdings)
  end

  def show
    @holding = EtfHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def edit
     @holding = EtfHolding.find_by_id params[:id]
     render :template => 'edit_securities/etf/edit_etf', :layout => false
   end
  def update
     @holding = EtfHolding.find_by_id params[:id]
     @holding.update_attributes(params[:etf_holding].except(:id))
     puts @holding.errors.full_messages
     render :json => {:success => true}

   end
  def create
    @holding = EtfHolding.create(params[:etf_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = EtfHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
