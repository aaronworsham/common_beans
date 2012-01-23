class StockHolding < ActiveRecord::Base

  include DateMixin
  belongs_to :user
  belongs_to :stock_ticker
  belongs_to :portfolio
  has_many :stock_buys
  has_many :stock_sells
  has_many :stock_events, :dependent => :destroy

  validates_presence_of :stock_ticker_id, :message => 'Must select a ticker'
  validates_presence_of :starting_shares
  validates_presence_of :starting_price


  #after_create :notify_everyone
  before_create :populate_net_values
  attr_accessor :ticker_name, :ticker_symbol

  def ticker
    @ticker ||= stock_ticker
  end

  def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end


  def populate_net_values
    self.starting_investment = self.starting_shares * self.starting_price
    self.net_shares = self.starting_shares
    self.net_investment = self.starting_investment
    self.net_return = 0
  end

  def populate_eod
    EOD.points.each do |pre, date|
      self.send("#{pre}_value=", self.send("#{pre}_calculated_value"))
      self.send("#{pre}_gain=", self.send("#{pre}_investment_gain_to_today"))
      self.save
    end
  end

  def update_net_values_for_buy(buy)
    self.update_attributes(
      :net_shares => self.net_shares + buy.shares,
      :net_investment => self.net_investment + buy.investment
    )
  end
  def reset_values_for_buy(buy)
    self.update_attributes(
      :net_shares => self.net_shares - buy.shares,
      :net_investment => self.net_investment - buy.investment
    )
  end


  def update_net_values_for_sell(sell)
    self.update_attributes(
      :net_shares => self.net_shares - sell.shares,
      :net_return => self.net_return + sell.roi
    )
  end
  def reset_values_for_sell(sell)
    self.update_attributes(
      :net_shares => self.net_shares + sell.shares,
      :net_return => self.net_return - sell.roi
    )
  end


  def days_since_holding_purchase
    humanize_seconds(Time.now - self.purchased_at) 
  end



  def todays_price
    @todays_price ||= self.ticker.todays_close
  end

  def todays_value
    (self.net_shares * self.todays_price).round
  end

  def total_gain
    self.todays_value + self.net_return - self.net_investment
  end

  def total_price_delta
    self.todays_price - self.starting_price
  end

  def past_shares(date)
    shares = net_shares
    stock_buys.each do |buy|
      shares - buy.shares if buy.executed_at > date
    end
    stock_sells.each do |sell|
      shares + sell.shares if sell.executed_at > date
    end
    shares
  end

  EOD.points.each do |pre, date|
    #######  Past Price
    define_method("#{pre}_price") do
      self.ticker.send("#{pre}_close")
    end

    ##### Past Value
    define_method("#{pre}_calculated_value") do
      self.send("#{pre}_price") * past_shares(date)
    end

    #####  Past Value Gain to today
    define_method("#{pre}_value_gain_to_today") do
      (self.todays_value - self.send("#{pre}_value")).round(2)
    end

    #####  Past investment Gain to today
    define_method("#{pre}_investment_gain_to_today") do
      (self.send("#{pre}_value_gain_to_today") - net_investment).round(2)
    end

    #####  Past investment Gain to today
    define_method("#{pre}_investment_gain_ratio_to_today") do
      (self.send("#{pre}_investment_gain_to_today")/self.todays_value).round(2)
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
    result
  end

end
