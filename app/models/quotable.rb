module Quotable
  def yahoo_symbol
    (read_attribute :yahoo_symbol) || self.symbol
  end

  def current_price
    if Settings.offline
      price = rand(100.0)
      logger.info 'Stubbing Current Price!!! ' + price.to_s
      price
    else
      current_quote.results[:last_trade]
    end
  rescue NoMethodError
    logger.error "Failed to get Current Quote for #{self.symbol}"
    return 0
  rescue => e
    logger.error e.message
    return 0
  end

  def close_for_date(date)
    raise 'Date must be a Ruby Date Object' unless date.respond_to?('to_date')
    if local_eod_by_date(date.to_date).present?
      local_eod_by_date(date.to_date).close
    elsif Settings.offline
      price = rand(100.0)
      logger.info 'Stubbing Past Price!!! ' + price.to_s
      price
    else
      create_eod(past_quote(date.to_date).results, date.to_date)
    end
  rescue NoMethodError
    logger.error "Failed to get Past Quote for #{self.symbol}"
    return 0
  rescue => e
    logger.error e.message
    return 0
  end


  def current_quote
    StockTracker::CurrentQuote.new(self.yahoo_symbol)
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
end