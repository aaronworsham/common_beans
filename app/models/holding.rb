class Holding < ActiveRecord::Base

  include DateMixin
  belongs_to :user
  belongs_to :ticker
  belongs_to :portfolio
  has_many :buys 
  has_many :sells 
  has_many :events, :dependent => :destroy

  validates_presence_of :ticker_id

  after_create :notify_everyone
  before_create :populate_net_values
  attr_accessor :ticker_name, :ticker_symbol

   def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end

  def standard_message
    self.ticker.yahoo_link
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
      :net_investment => self.net_investment + buy.investment,
    )
  end
  def reset_values_for_buy(buy)
    self.update_attributes(
      :net_shares => self.net_shares - buy.shares,
      :net_investment => self.net_investment - buy.investment,
    )
  end


  def update_net_values_for_sell(sell)
    self.update_attributes(
      :net_shares => self.net_shares - sell.shares,
      :net_return => self.net_return + sell.return_on_investment
    )
  end
  def reset_values_for_sell(sell)
    self.update_attributes(
      :net_shares => self.net_shares + sell.shares,
      :net_return => self.net_return - sell.return_on_investment
    )
  end


  def days_since_holding_purchase
    humanize_seconds(Time.now - self.date_of_purchase) 
  end

  def as_json(options={})
    result = super(options)
    result["ticker_name"] = self.ticker.name
    result["ticker_symbol"] = self.ticker.symbol
    result["relative_day"] = self.days_since_holding_purchase
    result["todays_value"] = self.todays_value
    result["total_gain"] = self.total_gain
    result["todays_price"] = self.todays_price
    result["price_delta"] = self.price_delta
    result["day_delta"] = self.day_delta
    result["week_delta"] = self.week_delta
    result["month_delta"] = self.month_delta
    result["year_delta"] = self.year_delta
    result
  end

  def todays_price
    self.ticker.todays_close
  end

  def yesterdays_price
    self.ticker.todays_close

  end

  def last_weeks_price
    self.ticker.todays_close

  end

  def last_months_price
    self.ticker.todays_close

  end

  def last_years_price
    self.ticker.todays_close

  end

  def todays_value
    self.net_shares * self.todays_price
  end

  def total_gain
    self.todays_value + self.net_return - self.net_investment
  end

  def price_delta
    self.todays_price - self.starting_price
  end

  def day_delta
    self.yesterdays_price - self.starting_price
  end
  def week_delta
    self.last_weeks_price - self.starting_price
  end
  def month_delta
    self.last_months_price - self.starting_price
  end
  def year_delta
    self.last_years_price - self.starting_price
  end
end
