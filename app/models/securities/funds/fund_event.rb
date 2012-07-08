class FundEvent < ActiveRecord::Base
  include DateMixin


  belongs_to :user
  belongs_to :fund_holding
  belongs_to :fund_ticker

  validates_presence_of :fund_holding
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
    @holding ||= fund_holding
  end

  def holding=(h)
    self.fund_holding = h
  end

  def ticker
    @ticker ||= fund_ticker
  end

  def ticker=(t)
    self.fund_ticker = t
  end

  def action
    self.type == 'FundBuy' ? 'Buy' : 'Sell'
  end



  def as_json(options={})
    result = super(options)
    result["action"] = self.action
    result["action_letter"] = self.type[0].capitalize
    result["relative_day"] = days_since_holding_purchase
    result['executed_on'] = self.executed_at.strftime('%D')
    result['portfolio_id'] = self.holding.portfolio_id
    result['units_to_date'] = self.units_to_date
    result['value_to_date'] = self.value_to_date
    result
  end

  def days_since_holding_purchase
    humanize_seconds(executed_at - self.holding.purchased_at)
  end


  def todays_price
    self.ticker.todays_close
  end

  def todays_value
    self.units * self.todays_price
  end

  def units_to_date
    self.holding.past_units(self.executed_at)
  end

  def value_to_date
    units_to_date * price
  end


end
