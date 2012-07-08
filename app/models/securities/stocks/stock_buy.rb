class StockBuy< StockEvent

  before_create :populate_investment
  after_create :update_holding
  after_destroy :reset_holding



  def populate_investment
    self.investment = (self.shares * self.price)
  end

  def update_holding
    self.holding.update_net_values_for_buy(self)
  end

  def reset_holding
    self.holding.reset_values_for_buy(self)
  end

  def investment
    self.shares * self.price
  end

  def roi
    0
  end

  def action
    'Buy'
  end


  def total_value_gain
    todays_value - self.investment
  end




end
