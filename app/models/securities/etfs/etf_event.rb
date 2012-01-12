class EtfEvent < ActiveRecord::Base
include DateMixin


  belongs_to :user
  belongs_to :etf_holding
  belongs_to :etf_ticker

  validates_presence_of :etf_holding
  validates_presence_of :user
  validates_presence_of :units
  validates_presence_of :price
  validates_presence_of :executed_at

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :action     => 'bought',
      :user     => self.user
    ).save
  end

  def standard_message
    " some units of #{ticker.yahoo_link} at #{self.price} per share"
  end

  def action_word
    "bought"
  end


  def holding
    @holding ||= etf_holding
  end

  def holding=(h)
    self.etf_holding = h
  end

  def ticker
    @ticker ||= etf_ticker
  end

  def ticker=(t)
    self.etf_ticker = t
  end


  def as_json(options={})
    result = super(options)
    result["action"] = self.type
    result["action_letter"] = self.type[0].capitalize
    result["relative_day"] = days_since_holding_purchase
    result
  end

  def days_since_holding_purchase
    humanize_seconds(executed_at - self.holding.purchased_at)
  end


  def todays_price
    self.etf_ticker.todays_close
  end

  def todays_value
    self.shares * self.todays_price
  end

end
