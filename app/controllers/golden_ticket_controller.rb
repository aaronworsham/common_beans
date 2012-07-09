class GoldenTicketController < ApplicationController
  def index
    cookies[:cb_golden_ticket] = true
    redirect_to root_path
  end
end
