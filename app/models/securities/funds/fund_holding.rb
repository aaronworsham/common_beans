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

  def populate_eod
    EOD.points.each do |pre, date|
      self.send("#{pre}_value=", self.send("#{pre}_calculated_value"))
      self.send("#{pre}_gain=", self.send("#{pre}_investment_gain_to_today"))
      self.save
    end
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

  def past_units(date)
    units = net_units
    fund_buys.each do |buy|
      units - buy.units if buy.executed_at > date
    end
    fund_sells.each do |sell|
      units + sell.units if sell.executed_at > date
    end
    units
  end

  def net_denomination
    net_units
  end

  def past_denomination(date)
    past_units(date)
  end


end
