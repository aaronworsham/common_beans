class BondSell< BondEvent

  before_create :populate_return
  after_create :update_holding
  after_destroy :reset_holding


  def populate_return
    self.roi = self.quantity * self.price
  end

  def update_holding
    self.holding.update_net_values_for_sell(self)
  end
  def reset_holding
    self.holding.reset_values_for_sell(self)
  end

  def roi
    self.quantity * self.price
  end

  def investment
    0
  end

  def total_value_gain
    self.roi - self.todays_value
  end

end
