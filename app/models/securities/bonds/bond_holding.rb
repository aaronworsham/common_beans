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
  validates_presence_of :starting_quantity

  before_create :populate_net_values
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

  def has_price?
    false
  end

  def populate_net_values
    self.net_quantity = self.starting_quantity
    self.net_investment = (self.purchase_price * self.starting_quantity)
    self.net_return = 0
  end

  def populate_eod
    EOD.points(Date.today).each do |pre, date|
      self.send("#{pre}_value=", self.send("#{pre}_calculated_value"))
      self.send("#{pre}_gain=", self.send("#{pre}_investment_gain_to_today"))
      self.save
    end
  end

  def num_coupons_from_today
    frequency * (matures_at.year - Date.today.year)
  end

  def num_coupons_from_date(date)
    frequency * (matures_at.year - date.year)
  end

  def num_coupons_from_purchase
    frequency * (matures_at.year - purchased_at.year)
  end

  def num_coupons_paid
    frequency * (Date.today.year - purchased_at.year)
  end

  def value_of_coupon_payments
    face_value * (coupon/frequency)
  end

  def frequency_yield
    expected_yield/frequency
  end

  def pv_of_redemption
    face_value / (1+frequency_yield)**num_coupons_from_today
  end

  def past_value_of_redemption(date)
    face_value / (1+frequency_yield)**num_coupons_from_date(date)
  end

  def pv_of_interest_payments
    value_of_coupon_payments * ((1-(1/(1+frequency_yield)**num_coupons_from_today))/frequency_yield)
  end

  def past_value_of_interest_payments(date)
    value_of_coupon_payments * ((1-(1/(1+frequency_yield)**num_coupons_from_date(date)))/frequency_yield)
  end

  def present_value
    pv = pv_of_redemption + pv_of_interest_payments
    pv.round(2) * net_quantity
  end

  def past_value(date)
    past_value = past_value_of_redemption(date) + past_value_of_interest_payments(date)
    past_value.round(2) * net_quantity
  end

  def update_net_values_for_sell(sell)
    self.update_attributes(
       :net_quantity  => (self.net_quantity - sell.quantity),
       :net_return    => (self.net_return + sell.roi)
    )
  end
  def reset_values_for_sell(sell)
    self.update_attributes(
       :net_quantity  => (self.net_quantity + sell.quantity),
       :net_return    => (self.net_return - sell.roi)
    )
  end

  def days_since_holding_purchase
    humanize_seconds(Time.now - self.purchased_at)
  end

  def total_return
    net_return + (value_of_coupon_payments * num_coupons_paid)
  end

  def total_value_gain
    self.present_value + self.total_return - self.net_investment
  end

  def todays_value
    self.present_value
  end

  def as_json(options={})
    result = super(options)
    result["todays_value"] = self.present_value.round(2)
    result["total_value_gain"] = self.total_value_gain.round(2)
    result
  end



end
