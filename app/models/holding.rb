class Holding < ActiveRecord::Base

  include DateMixin
  belongs_to :user
  belongs_to :ticker
  belongs_to :portfolio
  belongs_to :dow_index_eod
  has_many :buys
  has_many :sells 
  has_many :events, :dependent => :destroy

  validates_presence_of :ticker_id, :message => 'Must select a ticker'
  validates_presence_of :starting_shares
  validates_presence_of :starting_price


  after_create :notify_everyone
  after_create :link_to_dow_eod
  before_create :populate_net_values
  attr_accessor :ticker_name, :ticker_symbol

  def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end

  def link_to_dow_eod
    eod = DowIndexEod.find_by_closed_on(self.date_of_purchase.to_date.to_s(:db))
    self.update_attribute(:dow_index_eod, eod)
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
    result["day_delta_price"] = self.day_delta_price
    result["week_delta_price"] = self.week_delta_price
    result["one_month_delta_price"] = self.one_month_delta_price
    result["three_month_delta_price"] = self.three_month_delta_price
    result["six_month_delta_price"] = self.six_month_delta_price
    result["nine_month_delta_price"] = self.nine_month_delta_price
    result["one_year_delta_price"] = self.one_year_delta_price
    result["two_year_delta_price"] = self.two_year_delta_price
    result["three_year_delta_price"] = self.three_year_delta_price
    result
  end

  def todays_price
    @todays_price ||= self.ticker.todays_close
  end

  def yesterdays_price
    self.ticker.yesterdays_close
  end

  def last_weeks_price
    self.ticker.last_weeks_close

  end

  def one_month_price
    self.ticker.one_month_close
  end

  def three_month_price
    self.ticker.three_month_close
  end

  def six_month_price
    self.ticker.six_month_close
  end

  def nine_month_price
    self.ticker.nine_month_close
  end

  def one_year_price
    self.ticker.one_year_close
  end

  def two_year_price
    self.ticker.two_year_close
  end

  def three_year_price
    self.ticker.three_year_close
  end

  def todays_value
    (self.net_shares * self.todays_price).round
  end

  def total_gain
    self.todays_value + self.net_return - self.net_investment
  end

  def price_delta
    self.todays_price - self.starting_price
  end

  def day_delta_price
    (self.todays_price - self.yesterdays_price).round
  end
  def week_delta_price
    (self.todays_price - self.last_weeks_price).round
  end
  def one_month_delta_price
    (self.todays_price - self.one_month_price).round
  end
  def three_month_delta_price
    (self.todays_price - self.three_month_price).round
  end
  def six_month_delta_price
    (self.todays_price - self.six_month_price).round
  end

  def nine_month_delta_price
    (self.todays_price - self.nine_month_price).round
  end

  def one_year_delta_price
    (self.todays_price - self.one_year_price).round
  end
  def two_year_delta_price
    (self.todays_price - self.two_year_price).round
  end
  def three_year_delta_price
    (self.todays_price - self.three_year_price).round
  end

  def day_delta_value
    day_delta_price * net_shares
  end
  def week_delta_value
    week_delta_price * net_shares
  end
  def one_month_delta_value
    one_month_delta_price * net_shares
  end
  def three_month_delta_value
    three_month_delta_price * net_shares
  end
  def six_month_delta_value
    six_month_delta_price * net_shares
  end

  def nine_month_delta_value
    nine_month_delta_price * net_shares
  end

  def one_year_delta_value
    one_year_delta_price * net_shares
  end
  def two_year_delta_value
    two_year_delta_price * net_shares
  end
  def three_year_delta_value
    three_year_delta_price * net_shares
  end

  def dow_delta
    holding_dow_delta = DowIndex.investment_delta(
      :starting_investment => self.starting_investment,
      :todays_value => self.todays_value,
      :dow_eod => self.dow_index_eod
    )
    sum_buy_deltas = self.buys.inject(0){|sum, b| sum + b.dow_delta}
    return holding_dow_delta + sum_buy_deltas
  end
end
