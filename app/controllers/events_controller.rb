class EventsController < ApplicationController
  
  respond_to :html, :json
  def index
    @events = current_user.events
    respond_with(@events)
  end
  def create
    @event = Event.create(params[:event].merge(:user => current_user))
    respond_with(@event)
    
  end
  def destroy
    @event = Event.find_by_id params[:id]
    @event.destroy
    respond_with(@event)
  end
end
