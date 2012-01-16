class FundTickersController < ApplicationController
  autocomplete :fund_ticker, :name, :full => true
  autocomplete :fund_ticker, :symbol

  respond_to :json
  def show
    case params[:id]
    when 'autocomplete_fund_ticker_name'
      @tickers = FundTicker.where("name like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.name, :value => x.name}})
    when 'autocomplete_fund_ticker_symbol'
      @tickers = FundTicker.where("symbol like ?", "%#{params[:term]}%").all
      respond_with(@tickers.map{|x| {:id => x.id, :label => x.symbol, :value => x.symbol}})
    end
  end
end