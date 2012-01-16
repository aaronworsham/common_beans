class FundTicker < ActiveRecord::Base

  include Quotable
  include TickerLiquidity
  has_many :fund_holdings
  has_many :fund_ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def ticker_eods
    fund_ticker_eods
  end

  def create_eod(eod, date)
    raise "Missing EOD for #{self.class} #{self.symbol}" unless eod
    FundTickerEod.create(
      :fund_ticker => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  rescue => e
    logger.info e.message
  end

end