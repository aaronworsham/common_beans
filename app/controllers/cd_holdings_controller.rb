class CdHoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.holdings
    respond_with(@holdings)
  end

  def show
    @holding = CdHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def edit
     @holding = CdHolding.find_by_id params[:id]
     render :template => 'edit_securities/cd/edit_cd', :layout => false
   end
  def update
     params[:cd_holding][:purchased_at] = Date.strptime(params[:cd_holding][:purchased_at], '%m/%d/%Y')
     @holding = CdHolding.find_by_id params[:id]
     @holding.update_attributes(params[:cd_holding].except(:id))
     puts @holding.errors.full_messages
     render :json => {:success => true}

  end
  def create
    params[:cd_holding][:purchased_at] = Date.strptime(params[:cd_holding][:purchased_at], '%m/%d/%Y')
    @holding = CdHolding.create(params[:cd_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = CdHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
