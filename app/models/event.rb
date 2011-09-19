class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :holding
  belongs_to :ticker

  def as_json(options={})
    result = super(options)
    result["action"] = self.type
    result["action_letter"] = self.type[0].capitalize
    result["relative_day"] = days_since_holding_purchase
    result
  end

  def todays_price
    self.ticker.todays_close
  end

  def todays_value
    self.shares * self.todays_price
  end

end
