class TrackersController < ApplicationController
  respond_to :html, :json
  def index
    @profiles = current_user.profiles
    @holdings = current_user.holdings
    @events = current_user.events
    @buy = Buy.new
    @sell = Sell.new  end

end
