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
    close_for_date(1.day.ago.to_date)
  end

  def last_weeks_close
    close_for_date(1.week.ago.to_date)
  end

  def one_month_close
    close_for_date(1.month.ago.to_date)
  end

  def three_month_close
    close_for_date(3.month.ago.to_date)
  end

  def six_month_close
    close_for_date(6.month.ago.to_date)
  end

  def nine_month_close
    close_for_date(9.month.ago.to_date)
  end

  def one_year_close
    close_for_date(1.year.ago.to_date)
  end

  def two_year_close
    close_for_date(2.year.ago.to_date)
  end

  def three_year_close
    close_for_date(3.year.ago.to_date)
  end



  def local_eod_by_date(date)
    self.ticker_eods.where("closed_on = ?", date.to_s(:db))
  end

  def close_for_date(date)
    raise 'Date must be a Ruby Date Object' unless date.is_a?(Date)
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
    raise 'Date must be a Ruby Date Object' unless date.is_a?(Date)
    quote = StockTracker::PastQuote.new(self.symbol, date)
    if quote.results.nil?
      quote = past_quote(date - 1)
    end
    quote
  end



end
