module Quotable


  def date_for_eod

  end

  def yahoo_symbol
    (read_attribute :yahoo_symbol) || self.symbol
  end

  def todays_close
    current_quote.results[:last_trade]
  end

  EOD.points.each do |k,v|
    define_method("#{k}_close") do
      close_for_date(v.to_date)
    end
  end


  def close_for_date(date)
    raise 'Date must be a Ruby Date Object' unless date.is_a?(Date)
    if local_eod_by_date(date).present?
      local_eod_by_date(date).close
    else
      create_eod(past_quote(date).results, date)
    end
  rescue => e
    logger.info e.message
    return 0
  end


  def current_quote
    StockTracker::CurrentQuote.new(self.yahoo_symbol == '^DJI' ? 'INDU' : self.yahoo_symbol)
  end

  def past_quote(date, i = 7)
    raise 'Date must be a Ruby Date Object' unless date.is_a?(Date)
    quote = StockTracker::PastQuote.new(self.yahoo_symbol, date)
    if quote.results.nil? and i > 0
      quote = past_quote((date - 1), i - 1 )
    end
    puts "Found it in #{i - 6}"
    raise "Could not locate Past Quote for #{self.symbol} for #{date}" unless quote.results
    quote
  end



  def as_json(options={})
    result = super(options)
    EOD.points.each do |x|
      result["#{x}_close"] = self.send("#{x}_close")
    end
    result
  end


end