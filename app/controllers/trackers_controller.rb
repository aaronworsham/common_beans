class TrackersController < ApplicationController
  respond_to :html, :json
  before_filter :login_required
  layout 'tracker'
  def index
    @portfolios = current_user.portfolios
    @holdings = current_user.holdings
    @events = current_user.events
    @buy = Buy.new
    @sell = Sell.new  end

end
