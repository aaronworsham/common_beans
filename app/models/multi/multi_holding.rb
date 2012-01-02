class MultiHolding < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :portfolio
  has_many    :multi_holding_allocations
  has_many    :multi_statements
  has_many    :multi_statement_allocations, :through => :multi_statements

  def percent_allocated
    percent = 0
    multi_holding_allocations.active.each do |a|
      percent += a.allocation_percentage
    end
    percent
  end

  def total_contrib_from_alloc
    contrib = 0
    multi_statement_allocations.each do |a|
      contrib += (a.contributions || 0)
    end
    contrib
  end

  def total_distrib_from_alloc
    distrib = 0
    multi_statement_allocations.each do |a|
      distrib += (a.distributions || 0)
    end
    distrib
  end

  def update_investments
    self.update_attributes(
            :net_investment => total_contrib_from_alloc,
            :net_return => total_distrib_from_alloc
    )
  end

  def reallocate(new_array)
    current_array = multi_holding_allocations
    new_fund_ids = new_array.map{|x| x[:fund_ticker_id]}
    current_fund_ids = current_array.map{|x| x.fund_ticker_id}

    deactivate = current_fund_ids - new_fund_ids
    update = current_fund_ids & new_fund_ids
    create = new_fund_ids - current_fund_ids

    deactivate.each do |id|
      current_alloc = current_array.select{|x| x.fund_ticker_id == id}.first
      current_alloc.deactivate! if current_alloc.active?
      current_alloc.update_attributes(
                :allocation_percentage => 0,
                :estimated_units => 0
      ) if (current_alloc.allocation_percentage > 0 or current_alloc.estimated_units > 0)
    end

    update.each do |id|
      current_alloc = current_array.select{|x| x.fund_ticker_id == id}.first
      new_alloc = new_array.select{|x| x[:fund_ticker_id] == id}.first
      current_alloc.update_attributes(
              :allocation_percentage => new_alloc[:allocation],
              :estimated_units => new_alloc[:estimated_units]
      )
      current_alloc.activate! if current_alloc.inactive?
    end

    create.each do |id|
      new_alloc = new_array.select{|x| x[:fund_ticker_id] == id}.first
      MultiHoldingAllocation.create(
        :multi_holding => self,
        :fund_ticker_id => new_alloc[:fund_ticker_id],
        :allocation_percentage => new_alloc[:allocation],
        :estimated_units => new_alloc[:estimated_units]
      )
    end
    self.reload
    self.update_investments
  end

end
