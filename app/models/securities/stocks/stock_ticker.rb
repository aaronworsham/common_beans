class StockTicker < ActiveRecord::Base

  include Quotable
  include TickerLiquidity
  has_many :stock_holdings
  has_many :stock_ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def ticker_eods
    stock_ticker_eods
  end

  def create_eod(eod, date)
    StockTickerEod.create(
      :stock_ticker => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  end



end
