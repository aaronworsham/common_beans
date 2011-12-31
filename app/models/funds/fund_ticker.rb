class FundTicker < ActiveRecord::Base

  include Quotable
  include TickerLiquidity
  has_many :fund_holdings
  has_many :fund_ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol



  def create_eod(eod, date)
    FundTickerEod.create(
      :fund_ticker => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  end

end