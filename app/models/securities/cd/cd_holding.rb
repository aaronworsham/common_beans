class CdHolding < ActiveRecord::Base
  include DateMixin
  belongs_to :user
  belongs_to :portfolio
  has_many :cd_sells
  has_many :cd_events, :dependent => :destroy

  validates_presence_of :coupon
  validates_presence_of :matures_at
  validates_presence_of :purchase_price
  validates_presence_of :face_value
  validates_presence_of :frequency
  validates_presence_of :purchased_at
  validates_presence_of :starting_quantity

  before_create :populate_net_values


  def ticker
    @ticker ||= cd_ticker
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

  def num_coupons_from_today
    frequency * (matures_at.year - Date.today.year)
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

  def pv_of_interest_payments
    value_of_coupon_payments * ((1-(1/(1+frequency_yield)**num_coupons_from_today))/frequency_yield)
  end

  def present_value
    pv = pv_of_redemption + pv_of_interest_payments
    pv.round(2) * net_quantity
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
