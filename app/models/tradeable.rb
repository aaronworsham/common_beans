module Tradeable

  def calculate_value(date)
    if date == Date.today
      ticker.current_price * net_denomination
    else
      ticker.close_for_date(date) * past_denomination(date)
    end
  end

  def calculate_value_gain(date1, date2)
    calculate_value(date1) - calculate_value(date2)
  end

  def calculate_investment_gain(date1, date2)
    calculate_value_gain(date1, date2) - net_investment
  end

  def calculate_investment_gain_ratio(date1, date2)
    (calculate_investment_gain(date1, date2)/calculate_value(date1)).round(3)
  end

  #cant use define_method and keep default param syntax
  def d7_close(date = Date.today)
    ticker.close_for_date( Point.date('d7',date))
  end
  def d30_close(date = Date.today)
    ticker.close_for_date( Point.date('d30',date))
  end
  def d180_close(date = Date.today)
    ticker.close_for_date( Point.date('d180',date))
  end
  def d365_close(date = Date.today)
    ticker.close_for_date( Point.date('d365',date))
  end
  def y2_close(date = Date.today)
    ticker.close_for_date( Point.date('y2',date))
  end
  def y3_close(date = Date.today)
    ticker.close_for_date( Point.date('y3',date))
  end
  def y4_close(date = Date.today)
    ticker.close_for_date( Point.date('y4',date))
  end
  def y5_close(date = Date.today)
    ticker.close_for_date( Point.date('y5',date))
  end

  Point.names.each do |pre|

    define_method("#{pre}_calculated_value") do |date|
      calculate_value(Point.date(pre, date))
    end
    define_method("#{pre}_calculated_value_gain") do |date|
      calculate_value_gain(date, Point.date(pre, date))
    end
    define_method("#{pre}_calculated_investment_gain") do |date|
      calculate_investment_gain(date, Point.date(pre, date))
    end
    define_method("#{pre}_calculated_investment_gain_ratio") do |date|
      calculate_investment_gain_ratio(date, Point.date(pre, date))
    end
  end

  def populate_eod(date = Date.today)
    Point.names.each do |pre|
      self.send("#{pre}_value=", self.send("#{pre}_calculated_value", date))
      self.send("#{pre}_gain=", self.send("#{pre}_calculated_value_gain", date))
      self.save
    end
  end

end