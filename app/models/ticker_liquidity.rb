module TickerLiquidity
  def yahoo_link
    "<a target='_blank' href='http://finance.yahoo.com/q?s=#{self.symbol}'>#{self.name}(#{self.symbol})</a>"
  end

  def local_eod_by_date(date)
    self.ticker_eods.where("closed_on = ?", date.to_s(:db)).first
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