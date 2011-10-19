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
    current_quote.results[:last_trade]
  end

  def yesterdays_close
    past_quote(1.day.ago.to_date).results[:close]
  end

  def last_weeks_close
    past_quote(1.week.ago.to_date).results[:close]
  end

  def last_months_close
    past_quote(1.month.ago.to_date).results[:close]
  end

  def last_years_close
    past_quote(1.year.ago.to_date).results[:close]
  end

  def local_eod_by_date(date)
    self.ticker_eods.where("closed_on = ?", date.to_s(:db))
  end

  def close_for_date(date_str)
    date = Date.parse(date_str)
    if local_eod_by_date(date).present?
      local_eod_by_date(date).first.close
    else
      eod = past_quote(date).results
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

  def current_quote
    StockTracker::CurrentQuote.new(self.symbol)
  end

  def past_quote(date)
    StockTracker::PastQuote.new(self.symbol, date)
  end



end
