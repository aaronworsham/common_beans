class Ticker < ActiveRecord::Base
  has_many :holdings
  belongs_to :exchange

  validates_presence_of :name
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def yahoo_link
    "<a target='_blank' href='http://finance.yahoo.com/q?s=#{self.symbol}'>#{self.name}(#{self.symbol})</a>"
  end 

  def todays_close
    TickerEod.new.close
  end

end
