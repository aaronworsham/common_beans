class TickerCurrent < Valuable
  has_value :ticker
  has_value :symbol
  has_value :name
  has_value :lastTrade
  has_value :date
  has_value :time
  has_value :change
  has_value :changePoints
  has_value :changePercent
  has_value :previousClose
  has_value :open
  has_value :dayHigh
  has_value :dayLow
  has_value :volume
  has_value :dayRange
  has_value :lastTradeWithTime
  has_value :tickerTrend
  has_value :averageDailyVolume
  has_value :bid
  has_value :ask



  def self.create(ticker)
    @ticker = ticker
    self.new(self.ping_tracker)
  end


  def ping_tracker
    self.resource.yahoo_quote.attributes
  end

  def self.resource
    @resource ||= TickerResource.find(@ticker.symbol, :params => {:exchange_id => @ticker.exchange.name} )
  end
end