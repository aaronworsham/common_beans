class DashboardController < ApplicationController
  before_filter :login_required
  
  def show
    @portfolios = current_user.portfolios
    @holdings = current_user.holdings
    @dji_index = Index.find_by_symbol('DJI')
    @messages = MessageEveryone.reader.read
    @messages_everyone_count = MessageEveryone.reader.count
    @friends = current_user.friends
  end
end
