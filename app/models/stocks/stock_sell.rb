class StockSell< StockEvent

  before_create :populate_return
  after_create :update_holding
  after_destroy :reset_holding

  #def notify_everyone
  #  MessageEveryone.new(
  #    :text     => standard_message,
  #    :action   => 'sold',
  #    :user     => self.user
  #  ).save
  #end
  #
  #def standard_message
  #  "some shares of #{ticker.symbol} at #{self.price} per share"
  #end
  #
  #def action_word
  #  "sold"
  #end


  def populate_return
    self.roi = self.shares * self.price
  end

  def update_holding
    self.holding.update_net_values_for_sell(self)
  end
  def reset_holding
    self.holding.reset_values_for_sell(self)
  end

  def roi
    self.shares * self.price
  end

  def investment
    0
  end

  def days_since_holding_purchase
    humanize_seconds(date_of_event - self.holding.date_of_purchase)
  end
  #def as_json(options={})
  #  result = super(options)
  #  result["action"] = self.class.name
  #  result["action_letter"] = self.action_word[0].capitalize
  #  result["investment"] = 0
  #  result["relative_day"] = days_since_holding_purchase
  #  result
  #end

  def total_gain
    self.roi - self.todays_value
  end

end
