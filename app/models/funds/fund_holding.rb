class FundHolding < ActiveRecord::Base
include DateMixin
  belongs_to :user
  belongs_to :fund_ticker
  belongs_to :portfolio
  has_many :fund_buys
  has_many :fund_sells
  has_many :fund_events, :dependent => :destroy

  validates_presence_of :fund_ticker_id, :message => 'Must select a ticker'
  validates_presence_of :starting_units
  validates_presence_of :starting_price


  #after_create :notify_everyone
  before_create :populate_net_values
  attr_accessor :ticker_name, :ticker_symbol


  EOD = %w(day week one_month three_month six_month nine_month one_year two_year three_year)

  def ticker
    @ticker ||= fund_ticker
  end

  def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end


  def populate_net_values
    self.starting_investment = self.starting_units * self.starting_price
    self.net_units = self.starting_units
    self.net_investment = self.starting_investment
    self.net_return = 0
  end

  def update_net_values_for_buy(buy)
    self.update_attributes(
      :net_units => self.net_units + buy.units,
      :net_investment => self.net_investment + buy.investment
    )
  end
  def reset_values_for_buy(buy)
    self.update_attributes(
      :net_units => self.net_units - buy.units,
      :net_investment => self.net_investment - buy.investment
    )
  end


  def update_net_values_for_sell(sell)
    self.update_attributes(
      :net_units => self.net_units - sell.units,
      :net_return => self.net_return + sell.roi
    )
  end
  def reset_values_for_sell(sell)
    self.update_attributes(
      :net_units => self.net_units + sell.units,
      :net_return => self.net_return - sell.roi
    )
  end


  def days_since_holding_purchase
    humanize_seconds(Time.now - self.purchased_at)
  end



  def todays_price
    @todays_price ||= self.fund_ticker.todays_close
  end

  def todays_value
    (self.net_units * self.todays_price).round
  end

  def total_gain
    self.todays_value + self.net_return - self.net_investment
  end

  def total_price_delta
    self.todays_price - self.starting_price
  end


  EOD.each_with_index do |pre, i|
    #######  Past Price
    define_method("#{pre}_price") do
      self.fund_ticker.send("#{pre}_close")
    end

    #####  Past Price Gain to today
    define_method("#{pre}_price_gain_to_today") do
      (self.todays_price - self.send("#{pre}_price")).round(2)
    end

    ###### Past Price Delta Gain
    define_method("#{pre}_price_gain_delta") do
      if EOD[i + 1]
        (self.send("#{pre}_price") - self.send("#{EOD[i + 1]}_price")).round(2)
      else
        0.0
      end
    end

    ###### Past Price percent Delta Gain
    define_method("#{pre}_price_gain_percent_delta") do
      if EOD[i + 1]
        new_value = self.send("#{pre}_price")
        old_value = self.send("#{EOD[i + 1]}_price")
        (((new_value - old_value)/new_value)*100).round(2)
      else
        0.0
      end
    end

    ##### Past Value
    define_method("#{pre}_value") do
      self.send("#{pre}_price") * net_units
    end

    #####  Past Value Gain to today
    define_method("#{pre}_value_gain_to_today") do
      (self.todays_value - self.send("#{pre}_value")).round(2)
    end

    ###### Past Value Delta Gain
    define_method("#{pre}_value_gain_delta") do
      if EOD[i + 1]
        (self.send("#{pre}_value") - self.send("#{EOD[i + 1]}_value")).round(2)
      else
        0.0
      end
    end

    ###### Past Value percent Delta Gain
    define_method("#{pre}_value_gain_percent_delta") do
      if EOD[i + 1]
        new_value = self.send("#{pre}_value")
        old_value = self.send("#{EOD[i + 1]}_value")
        (((new_value - old_value)/new_value)*100).round(2)
      else
        0.0
      end
    end
  end


  def as_json(options={})
    result = super(options)
    result["ticker_name"] = self.ticker.name
    result["ticker_symbol"] = self.ticker.symbol
    result["relative_day"] = self.days_since_holding_purchase
    result["todays_value"] = self.todays_value
    result["total_gain"] = self.total_gain
    result["todays_price"] = self.todays_price
    result["total_price_delta"] = self.total_price_delta
    EOD.each do |x|
      %w( price price_gain_to_today price_gain_delta price_gain_percent_delta
          value value_gain_to_today value_gain_delta price_gain_percent_delta).each do |method|
        str = "#{x}_#{method}"
        result[str] = self.send(str)

      end
    end
    result
  end

end
