class BuysController < ApplicationController

  respond_to :html, :json

  def create
    @buy = Buy.create(params[:event].merge(:user => current_user))
    respond_with(@buy) 
  end

  def destroy
    @buy = Buy.find_by_id params[:id]
    @buy.destroy
    respond_with(@buy)
  end

  def buy_url(x)
    "/buys"
  end
end
