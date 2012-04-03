class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  
  def show
    @friends = current_user.friends
    @portfolios = current_user.portfolios
    @stock_holdings = current_user.stock_holdings
    @fund_holdings = current_user.fund_holdings
    @etf_holdings = current_user.etf_holdings
    @bond_holdings = current_user.bond_holdings
    @cd_holdings = current_user.cd_holdings
    @multi_holdings = current_user.multi_holdings
  end
end
