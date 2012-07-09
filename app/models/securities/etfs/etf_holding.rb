class EtfHolding < ActiveRecord::Base

  include DateMixin
  include Tradeable
  include Holdable

  belongs_to :user
  belongs_to :etf_ticker
  belongs_to :portfolio
  has_many :etf_buys
  has_many :etf_sells
  has_many :etf_events, :dependent => :destroy

  validates_presence_of :etf_ticker_id, :message => 'Please select a ticker from the autocomplete'
  validates_presence_of :starting_units, :message => 'Please select number of units'
  validates_presence_of :starting_price, :message => 'Please select a price'
  validates_presence_of :purchased_at, :message => 'Please select a purchase date'

  delegate  :name,
          :symbol,
          :to => :etf_ticker

  #after_create :notify_everyone
  before_create :populate_net_values
  attr_accessor :ticker_name, :ticker_symbol



  def ticker
    @ticker ||= etf_ticker
  end

  def name
    "#{ticker.name.truncate(30)}(#{ticker.symbol})"
  end

  def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end


  def has_price?
    true
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

  def past_units(date)
    units = net_units
    etf_buys.each do |buy|
      units - buy.units if buy.executed_at > date
    end
    etf_sells.each do |sell|
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

  def as_json(options={})
    result = super(options)
    result["ticker_symbol"] = self.ticker.symbol
    result["todays_price"] = self.todays_price.round(2)
    result["todays_value"] = self.todays_value.round(2)
    result["total_value_gain"] = self.total_value_gain.round(2)
    result
  end


end
