class Ticker < ActiveRecord::Base
  has_many :holdings
  has_many :ticker_eods
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol


  def yahoo_link
    "<a target='_blank' href='http://finance.yahoo.com/q?s=#{self.symbol}'>#{self.name}(#{self.symbol})</a>"
  end


  def todays_close
    current.lastTrade
  end

  def local_eod_by_date(date)
    self.ticker_eods.where("closed_on = ?", date.to_s(:db))
  end

  def close_for_date(date)
    if local_eod_by_date(date).present?
      local_eod_by_date(date).first.close
    elsif ticker_eod_resource(date)
      eod = ticker_eod_resource(date)
      TickerEod.create(
        :ticker => self,
        :high => eod.high.to_f,
        :low =>  eod.low.to_f,
        :open => eod.open.to_f,
        :close => eod.close.to_f,
        :closed_on => Date.parse(eod.closed_on)
      ).close
    else
      0
    end
  end



  def ticker_eod_resource(date)
    @eod_resource ||= TickerEodResource.find(date, :params => {:exchange_id => self.exchange.name, :ticker_id => self.symbol})
  rescue ActiveResource::ResourceNotFound => e
    return nil
  end

  def current
    @current ||= TickerCurrent.create(self)
  end



end
