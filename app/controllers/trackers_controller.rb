class TrackersController < ApplicationController
  respond_to :html, :json
  def index

  end

  def new

  end

  def create
    logger.info params.inspect
    @holding = Buy.create(params[:content])
    respond_with(@holding)
  end

  def holding_url(x)
    "/trackers"
  end

  def buy_url(x)
    "/trackers"
  end
end
