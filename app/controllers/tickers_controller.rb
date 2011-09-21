class TickersController < ApplicationController
  autocomplete :ticker, :name, :full => true
  autocomplete :ticker, :symbol
  def show

  end
end
