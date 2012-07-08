class StockEventsController < ApplicationController

  respond_to :json
  def destroy
    event = StockEvent.find_by_id params[:id]
    event.destroy
    respond_with(event)
  end

end
