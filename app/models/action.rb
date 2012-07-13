class Action
  def self.all
    actions = []
    (StockHolding.all + FundHolding.all + EtfHolding.all).each do |h|
      actions << {
        :user => h.user,
        :date => h.purchased_at.strftime('%D'),
        :reaction => 'Bought',
        :symbol => h.ticker.symbol,
        :price => h.starting_price,
        :current_price => h.todays_price,
        :up_down => h.up_down,
        :movement => h.movement
      }
    end
    (StockEvent.all + FundEvent.all + EtfEvent.all).each do |e|
      actions << {
        :user => e.user,
        :date => e.executed_at.strftime('%D'),
        :reaction => e.action,
        :symbol => e.symbol,
        :price => e.price,
        :current_price => e.todays_price,
        :up_down => e.up_down,
        :movement => e.movement
      }

    end
    actions
  end
end
