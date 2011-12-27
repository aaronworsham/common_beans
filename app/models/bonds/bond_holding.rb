class BondHolding < ActiveRecord::Base
include DateMixin
  belongs_to :user
  belongs_to :bond_ticker
  belongs_to :portfolio
  has_many :bond_sells
  has_many :bond_events, :dependent => :destroy

  validates_presence_of :coupon
  validates_presence_of :matures_at
  validates_presence_of :purchase_price
  validates_presence_of :face_value
  validates_presence_of :frequency
  validates_presence_of :purchased_at
  validates_presence_of :quantity


  attr_accessor :ticker_name, :ticker_symbol


  def ticker
    @ticker ||= bond_ticker
  end

  def notify_everyone
    MessageEveryone.new(
      :text           => standard_message,
      :action         => 'added a holding in',
      :user           => self.user
    ).save
  end

  def number_of_coupons
    frequency * (matures_at.year - Date.today.year)
  end

  def value_of_coupon_payments
    purchase_price * (coupon/frequency)
  end

  def frequency_yield
    expected_yield/frequency
  end

  def pv_of_redemption
    face_value / (1+frequency_yield)**number_of_coupons
  end

  def pv_of_interest_payments
    value_of_coupon_payments * ((1-(1/(1+frequency_yield)**number_of_coupons))/frequency_yield)
  end

  def present_value
    pv = pv_of_redemption + pv_of_interest_payments
    pv.round(2) * quantity
  end

  def update_net_values_for_sell(sell)
  end
  def reset_values_for_sell(sell)
  end

  def days_since_holding_purchase
    humanize_seconds(Time.now - self.purchased_at)
  end

  def todays_value
    (self.net_units * self.todays_price).round
  end

  def total_gain
    self.todays_value + self.net_return - self.net_investment
  end

end
