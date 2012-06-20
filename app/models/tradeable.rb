module Tradeable



  def days_since_holding_purchase
    humanize_seconds(Time.now - self.purchased_at)
  end

  def total_price_delta
    self.todays_price - self.starting_price
  end

  def todays_price
    self.ticker.current_price
  end

  def todays_value
    calculate_value(Date.today)
  end

  def total_value_gain
    calculate_value(Date.today) - self.net_investment
  end

  def total_value_gain_ratio
    ((total_value_gain/self.net_investment)*100).round(3)
  end

  def get_past_prices
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_close")
    end
    hash
  end

  def get_past_values
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_calculated_value")
    end
    hash
  end

  def get_past_price_gains
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_calculated_price_gain")
    end
    hash
  end

  def get_past_value_gains
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_calculated_value_gain")
    end
    hash
  end

  def get_past_value_gain_ratios
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_calculated_value_gain_ratio")
    end
    hash
  end

  def calculate_price_gain(pre)
    if Settings.offline
      rand(10000)
    else
      (self.todays_price - self.send("#{pre}_close")).round(3)
    end
  end

  def calculate_price_gain_ratio(pre)
    past_price = self.send("#{pre}_close")
    if Settings.offline
      rand(25)
    else
      ((self.todays_price - past_price)/past_price*100).round(3)
    end
  end

  Point.names.each do |pre|
    define_method("#{pre}_calculated_price_gain") do
      calculate_price_gain(pre)
    end
    define_method("#{pre}_calculated_price_gain_ratio") do
      calculate_price_gain_ratio(pre)
    end
  end





  def calculate_value(date)
    if Settings.offline
      rand(100000)
    elsif date == Date.today
      todays_price * net_denomination
    else
      self.ticker.close_for_date(date) * past_denomination(date)
    end
  end

  def calculate_value_gain(date1, date2)
    if Settings.offline
      rand(10000)
    else
      calculate_value(date2) - calculate_value(date1)
    end
  end

  def calculate_value_gain_ratio(date1, date2)
    gain = calculate_value_gain(date1, date2)
    value = calculate_value(date1)
    if Settings.offline
      rand(25)
    elsif gain == 0 || value == 0
      nil
    else
      (gain/value*100).round(3)
    end
  end

  def calculate_investment_gain(date1, date2)
    if Settings.offline
      rand(10000)
    else
      calculate_value_gain(date1, date2) - net_investment
    end
  end

  def calculate_investment_gain_ratio(date1, date2)
    if Settings.offline
      rand(25)
    else
      (calculate_investment_gain(date1, date2)/calculate_value(date1)).round(3)
    end
  end



  #cant use define_method and keep default param syntax
  def d5_close(date = Date.today)
    ticker.close_for_date( Point.date('d5',date))
  end
  def d30_close(date = Date.today)
    ticker.close_for_date( Point.date('d30',date))
  end
  def d90_close(date = Date.today)
    ticker.close_for_date( Point.date('d90',date))
  end
  def d180_close(date = Date.today)
    ticker.close_for_date( Point.date('d180',date))
  end
  def y1_close(date = Date.today)
    ticker.close_for_date( Point.date('y1',date))
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

    define_method("#{pre}_calculated_value") do
      calculate_value(Point.date(pre, Date.today))
    end
    define_method("#{pre}_calculated_value_gain") do
      calculate_value_gain(Point.date(pre, Date.today), Date.today)
    end
    define_method("#{pre}_calculated_value_gain_ratio") do
      calculate_value_gain_ratio(Point.date(pre, Date.today), Date.today)
    end
    define_method("#{pre}_calculated_investment_gain") do
      calculate_investment_gain(Point.date(pre, Date.today), Date.today)
    end
    define_method("#{pre}_calculated_investment_gain_ratio") do
      calculate_investment_gain_ratio(Point.date(pre, Date.today), Date.today)
    end
  end


  def populate_points
    past_prices = self.get_past_prices
    past_values = self.get_past_values
    past_price_gains = self.get_past_price_gains
    past_value_gains = self.get_past_value_gains
    past_value_gain_ratios = self.get_past_value_gain_ratios
    Point.names.each do |n|
      self.send("#{n}_price=", past_prices[n]) if self.has_price?
      self.send("#{n}_value=", past_values[n])
      self.send("#{n}_price_gain=", past_price_gains[n]) if self.has_price?
      self.send("#{n}_value_gain=", past_value_gains[n])
      self.send("#{n}_gain_ratio=", past_value_gain_ratios[n])
    end
    self.points_updated_at = Date.today
    self.save
  end
end