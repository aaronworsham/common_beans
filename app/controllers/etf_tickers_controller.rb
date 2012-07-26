class EtfTickersController < ApplicationController
  respond_to :json
  def autocomplete_etf_ticker_name
      @tickers = EtfTicker.search_name(params[:term])
      respond_with(@tickers)
  end
  def autocomplete_etf_ticker_symbol
      @tickers = EtfTicker.search_symbol(params[:term])
      respond_with(@tickers)
  end
end
