class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  
  def show
    @portfolios = current_user.portfolios
    @holdings = current_user.holdings
    @dji_index = Index.find_by_symbol('DJI')

    @friends = current_user.friends
  end
end
