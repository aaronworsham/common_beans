class DashboardController < ApplicationController
  before_filter :login_required
  
  def show
    @portfolios = current_user.portfolios
    @holdings = current_user.holdings
    @messages = MessageEveryone.head
    @messages_everyone_count = MessageEveryone.head_count
    @friends = current_user.friends
    @following = current_user.following
  end
end
