class FundTickersController < ApplicationController
  autocomplete :ticker, :name, :full => true
  autocomplete :ticker, :symbol

  respond_to :json
  def show
    @ticker = FundTicker.find_by_symbol(params[:id].upcase)
    respond_with(@ticker)
  end
end