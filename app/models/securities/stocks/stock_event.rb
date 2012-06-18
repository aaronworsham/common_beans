class StockEvent < ActiveRecord::Base
  include DateMixin


  belongs_to :user
  belongs_to :stock_holding
  belongs_to :stock_ticker

  validates_presence_of :stock_holding
  validates_presence_of :user
  validates_presence_of :shares
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
    @holding ||= stock_holding
  end

  def holding=(h)
    self.stock_holding = h
  end

  def ticker
    @ticker ||= stock_ticker
  end

  def ticker=(t)
    self.stock_ticker = t
  end

  def as_json(options={})
    result = super(options)
    result["action"] = self.type
    result["action_letter"] = self.type[0].capitalize
    result["relative_day"] = days_since_holding_purchase
    result['executed_on'] = self.executed_at.strftime('%D')
    result
  end

  def days_since_holding_purchase
    humanize_seconds(executed_at - self.holding.purchased_at)
  end


  def todays_price
    self.stock_ticker.todays_close
  end

  def todays_value
    self.shares * self.todays_price
  end

end
