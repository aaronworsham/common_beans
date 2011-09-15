class Holding < ActiveRecord::Base

  include DateMixin
  belongs_to :user
  belongs_to :ticker
  belongs_to :portfolio
  has_many :buys 
  has_many :sells 
  has_many :events, :dependent => :destroy

  after_create :notify_everyone
  before_create :populate_net_values

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
    result
  end

end
