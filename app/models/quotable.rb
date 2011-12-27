module Quotable
  EOD = %w(day week one_month three_month six_month nine_month one_year two_year three_year)

  def yahoo_symbol
    (read_attribute :yahoo_symbol) || self.symbol
  end

  def todays_close
    current_quote.results[:last_trade]
  end

  def day_close
    close_for_date(1.day.ago.to_date)
  end

  def week_close
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

  EOD.each_with_index do |pre, i|
    #####  Past Price Gain to today
    define_method("#{pre}_price_gain_to_today") do
      (self.todays_close - self.send("#{pre}_close")).round(2)
    end

    ###### Past Price Delta Gain
    define_method("#{pre}_price_gain_delta") do
      if EOD[i + 1]
        (self.send("#{pre}_close") - self.send("#{EOD[i + 1]}_close")).round(2)
      else
        0.0
      end
    end

    ###### Past Price percent Delta Gain
    define_method("#{pre}_price_gain_percent_delta") do
      if EOD[i + 1]
        new_value = self.send("#{pre}_close")
        old_value = self.send("#{EOD[i + 1]}_close")
        (((new_value - old_value)/new_value)*100).round(2)
      else
        0.0
      end
    end

    def close_for_date(date)
      raise 'Date must be a Ruby Date Object' unless date.is_a?(Date)
      if local_eod_by_date(date).present?
        local_eod_by_date(date).close
      else
        create_eod(past_quote(date).results, date)
      end
    end
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
    quote
  end


  def as_json(options={})
    result = super(options)
    EOD.each do |x|
      result["#{x}_close"] = self.send("#{x}_close")
      result["#{x}_price_gain_to_today"] = self.send("#{x}_price_gain_to_today")
      result["#{x}_price_gain_delta"] = self.send("#{x}_price_gain_delta")
      result["#{x}_price_gain_percent_delta"] = self.send("#{x}_price_gain_percent_delta")
    end
    result
  end


end