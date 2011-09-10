class BuysController < ApplicationController

  respond_to :html, :json

  def create
    @buy = Buy.create(params[:buy].merge(:user => current_user))
    respond_with(@buy) 
  end

  def buy_url(x)
    "/buys"
  end
end
