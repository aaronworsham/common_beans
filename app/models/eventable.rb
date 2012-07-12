module Eventable
  def movement
    (todays_price - price).round(2)
  end

  def up_down
    if movement > 0
      'Up'
    else
      'Down'
    end
  end

  def reaction
    self.action == 'Buy' ? 'Bought' : 'Sold'
  end

  def symbol
    ticker.symbol
  end

  
  def todays_price
    self.ticker.current_price
  end


end
