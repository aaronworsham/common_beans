class TickersController < ApplicationController

  respond_to :json
  def show
    case params[:id]
    when 'autocomplete_ticker_name'
      @tickers = Ticker.where("name like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.name, :value => x.name}})
    when 'autocomplete_ticker_symbol'
      @tickers = Ticker.where("symbol like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.symbol, :value => x.symbol}})
    end


  end
end
