class StockHolding < ActiveRecord::Base

  include DateMixin
  include Tradeable


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
    shares = net_shares
    stock_buys.each do |buy|
      shares - buy.shares if buy.executed_at > date
    end
    stock_sells.each do |sell|
      shares + sell.shares if sell.executed_at > date
    end
    shares
  end

  def net_denomination
    net_shares
  end

  def past_denomination(date)
    past_shares(date)
  end



end
