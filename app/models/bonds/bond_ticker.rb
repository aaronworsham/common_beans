class BondTicker < ActiveRecord::Base

  include Quotable
  include TickerLiquidity
  has_many :bond_holdings
  has_many :bond_ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def ticker_eods
    bond_ticker_eods
  end

  def create_eod(eod, date)
    TickerEod.create(
      :ticker => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  end

end