class MultiStatement < ActiveRecord::Base

  belongs_to :user

  belongs_to :multi_holding
  has_many :multi_statement_allocations

  accepts_nested_attributes_for :multi_statement_allocations

  after_create do |x|
    allocations = []
    x.multi_statement_allocations.each do |msa|
      allocations << {
        :fund_ticker_id => msa.fund_ticker_id,
        :allocation => msa.allocation_percentage,
        :contributions => msa.contributions,
        :estimated_units => msa.estimated_units
      }
    end
    x.multi_holding.reallocate(allocations)
  end

  def allocation_array
    allocations = []
    self.multi_statement_allocations.each do |msa|
      allocations << {
        :fund_ticker_id => msa.fund_ticker_id,
        :allocation => msa.allocation_percentage,
        :contributions => msa.contributions,
        :estimated_units => msa.estimated_units
      }
    end
    allocations
  end

  def as_json(options={})
    result = super(options)
    result["multi_allocations"] = multi_statement_allocations
    result
  end

end
