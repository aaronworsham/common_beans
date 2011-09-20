class TickersController < ApplicationController
  autocomplete :ticker, :name, :full => true
  def show

  end
end
