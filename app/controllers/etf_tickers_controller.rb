class EtfTickersController < ApplicationController
  autocomplete :etf_ticker, :name, :full => true
  autocomplete :etf_ticker, :symbol

  respond_to :json
  def show
    case params[:id]
    when 'autocomplete_Etf_ticker_name'
      @tickers = EtfTicker.where("name like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.name, :value => x.name}})
    when 'autocomplete_Etf_ticker_symbol'
      @tickers = EtfTicker.where("symbol like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.symbol, :value => x.symbol}})
    end
  end
end