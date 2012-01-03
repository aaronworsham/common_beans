class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  
  def show
    @friends = current_user.friends
    @portfolios = current_user.portfolios
    @holdings = current_user.holdings
    @events = current_user.events
    @buy = StockBuy.new
    @sell = StockSell.new
  end
end
