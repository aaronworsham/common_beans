class MultiStatementAllocation < ActiveRecord::Base
  belongs_to :multi_statement
  belongs_to :fund_ticker

  attr_accessor  :ticker_name, :ticker_symbol

  before_create do |x|
    x.contributions = multi_statement.contributions * (allocation_percentage / 100)
    end_date = multi_statement.ended_on
    x.allocated_on = end_date
    x.price_at_allocation = self.fund_ticker.close_for_date(end_date)
    x.est_value_at_allocation = (multi_statement.ending_balance * (allocation_percentage / 100))
    x.est_units = if x.price_at_allocation > 0
       (x.est_value_at_allocation / x.price_at_allocation)
    else
      0
    end

  end

  after_create do |x|
    x.update_attribute(:estimated_units, calculate_units)
  end

  def calculate_units
    close = fund_ticker.close_for_date(multi_statement.ended_on)
    bal = multi_statement.ending_balance
    (bal * (allocation_percentage / 100) / close)
  end

  def as_json(options={})
    result = super(options)
    result["fund_symbol"] = fund_ticker.symbol
    result["fund_name"] = fund_ticker.name
    result
  end
end
