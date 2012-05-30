class StockHoldingsController < ApplicationController
  respond_to :html, :json

  def index
    @holdings = current_user.stock_holdings
    respond_with(@holdings)
  end

  def show
    @holding = StockHolding.find_by_id params[:id]
    respond_with(@holding)
  end

  def edit
    @holding = StockHolding.find_by_id params[:id]
    render :template => 'edit_securities/stock/edit_stock', :layout => false
  end

  def update
    params[:stock_holding][:purchased_at] = Date.strptime(params[:stock_holding][:purchased_at], '%m/%d/%Y')
    @holding = StockHolding.find_by_id params[:id]
    @holding.update_attributes(params[:stock_holding].except(:id))
    puts @holding.errors.full_messages
    render :json => {:success => true}

  end

  def create
    params[:stock_holding][:purchased_at] = Date.strptime(params[:stock_holding][:purchased_at], '%m/%d/%Y')
    @holding = StockHolding.create(params[:stock_holding].merge(:user => current_user))
    respond_with(@holding)
  end
  def destroy
    @holding = StockHolding.find_by_id params[:id]
    @holding.destroy
    respond_with(@holding)
  end
end
