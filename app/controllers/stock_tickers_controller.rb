class StockTickersController < ApplicationController
  respond_to :json
  def autocomplete_stock_ticker_name
      @tickers = StockTicker.search_name(params[:term])
      respond_with(@tickers)
  end
  def autocomplete_stock_ticker_symbol
      @tickers = StockTicker.search_symbol(params[:term])
      respond_with(@tickers)
  end
end
