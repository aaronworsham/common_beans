class MultiStatementAllocation < ActiveRecord::Base
  belongs_to :multi_statement
  belongs_to :fund_ticker
  attr_accessor :total_contribution

  before_create do |x|
    x.contributions = total_contribution * (allocation_percentage / 100)
  end

  after_create do |x|
    x.update_attribute(:estimated_units, calculate_units)
  end

  def calculate_units
    close = fund_ticker.close_for_date(multi_statement.ended_on)
    bal = multi_statement.ending_balance
    (bal * (allocation_percentage / 100) / close)
  end


end
