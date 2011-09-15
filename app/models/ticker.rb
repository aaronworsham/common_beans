class Ticker < ActiveRecord::Base
  has_many :holdings
  belongs_to :exchange

  def yahoo_link
    "<a target='_blank' href='http://finance.yahoo.com/q?s=#{self.symbol}'>#{self.name}(#{self.symbol})</a>"
  end 

end
