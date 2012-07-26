class FundTickersController < ApplicationController
  respond_to :json
  def autocomplete_fund_ticker_name
      @tickers = FundTicker.search_name(params[:term])

      respond_with(@tickers)
  end
  def autocomplete_fund_ticker_symbol
      @tickers = FundTicker.search_symbol(params[:term])
      respond_with(@tickers)
  end

end
