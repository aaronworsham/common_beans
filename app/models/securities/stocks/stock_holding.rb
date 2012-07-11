class StockHolding < ActiveRecord::Base

  include DateMixin
  include Tradeable
  include Holdable

  belongs_to :user
  belongs_to :stock_ticker
  belongs_to :portfolio
  has_many :stock_buys, :dependent => :destroy
  has_many :stock_sells, :dependent => :destroy
  has_many :stock_events, :dependent => :destroy

  validates_presence_of :stock_ticker_id, :message => 'Please select a ticker from the autocomplete'
  validates_presence_of :starting_shares, :message => 'Please select number of shares'
  validates_presence_of :starting_price, :message => 'Please select a price'
  validates_presence_of :purchased_at, :message => 'Please select a purchase date'



  #after_create :notify_everyone
  before_create :populate_net_values

  attr_accessor :ticker_name, :ticker_symbol

  def populate_portfolio_points

  end

  def ticker
    @ticker ||= stock_ticker
  end

  def events
    stock_events
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
    self.starting_investment = self.starting_shares * self.starting_price
    self.net_shares = self.starting_shares
    self.net_investment = self.starting_investment
    self.net_return = 0
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


  def past_shares(date)
    shares = starting_shares
    stock_buys.each do |buy|
      shares += buy.shares if buy.executed_at <= date
    end
    stock_sells.each do |sell|
      shares -= sell.shares if sell.executed_at <= date
    end
    shares
  end

  def net_denomination
    net_shares
  end

  def past_denomination(date)
    past_shares(date)
  end

  def as_json(options={})
    result = super(options)
    result["ticker_symbol"] = self.ticker.symbol
    result["todays_price"] = self.todays_price.round(2)
    result["todays_value"] = self.todays_value.round(2)
    result["total_value_gain"] = self.total_value_gain.round(2)
    result["name"] = self.ticker.name
    result["symbol"] = self.ticker.symbol
    result["purchased_on"] = self.purchased_at.strftime('%D')
    result
  end



end
