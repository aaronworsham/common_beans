class EventsController < ApplicationController
  
  respond_to :html, :json
  def index
    @events = current_user.events
    respond_with(@events)
  end
end
