class Ticker < ActiveRecord::Base

  include Quotable

  has_many :stock_holdings
  has_many :ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def yahoo_link
    "<a target='_blank' href='http://finance.yahoo.com/q?s=#{self.symbol}'>#{self.name}(#{self.symbol})</a>"
  end

  def local_eod_by_date(date)
    self.ticker_eods.where("closed_on = ?", date.to_s(:db))
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

  def as_json(options={})
    result = super(options)
    EOD.each do |x|
      str = "#{x}_close"
      result[str] = self.send(str)
    end
    result
  end

end
