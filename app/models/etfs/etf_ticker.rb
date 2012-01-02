class EtfTicker < ActiveRecord::Base

  include Quotable
  include TickerLiquidity
  has_many :etf_holdings
  has_many :etf_ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def ticker_eods
    etf_ticker_eods
  end


  def create_eod(eod, date)
    EtfTickerEod.create(
      :ticker => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  end

end