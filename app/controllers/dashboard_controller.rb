class DashboardController < ApplicationController
  before_filter :login_required
  
  def show
    @portfolio = current_user.portfolios.first
    @holdings = @portfolio.try('holdings') || []
    @messages = MessageEveryone.head
  end
end
