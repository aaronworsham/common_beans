class MultiHolding < ActiveRecord::Base

  extend Holdable
  include Tradeable
  include Holdable

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

  def total_contrib_from_statements
    contrib = 0
    multi_statements.each do |a|
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
            :net_investment => total_contrib_from_statements,
            :net_return => total_distrib_from_alloc
    )
  end

  def allocate(array)
    #puts "Allocating : #{array}"

    array.each do |alloc|
      self.multi_holding_allocations.create(
        :fund_ticker_id => alloc[:fund_ticker_id],
        :allocation_percentage => alloc[:allocation],
        :estimated_units => alloc[:estimated_units],
        :allocated_on => alloc[:allocated_on],
        :price_at_allocation => alloc[:price_at_allocation],
        :est_value_at_allocation => alloc[:est_value_at_allocation],
        :est_units => alloc[:est_units]

      )
    end
  end

  def update_allocation(array)
    #puts "Updating allocation : #{array}"

     array.each do |alloc|
      current_alloc = find_alloc_by_fund_ticker_id(alloc[:fund_ticker_id])
      current_alloc.update_attributes(
              :allocation_percentage => alloc[:allocation],
              :estimated_units => alloc[:estimated_units]
      )
      current_alloc.activate! if current_alloc.inactive?
    end
  end

  def deactivate_allocation(array)
    #puts "Deactivating allocation : #{array}"
    array.each do |alloc|
      current_alloc = find_alloc_by_fund_ticker_id(alloc[:fund_ticker_id])
      current_alloc.update_attributes(
                :allocation_percentage => 0,
                :estimated_units => 0
      ) if (current_alloc.allocation_percentage > 0 or current_alloc.estimated_units > 0)
      current_alloc.deactivate! if current_alloc.active?
    end
  end

  def reallocate(array = self.multi_statements.last.allocation_array)
    new_fund_ids = array.map{|x| x[:fund_ticker_id]}
    current_fund_ids = multi_holding_allocations.map{|x| x.fund_ticker_id}
    deactivate_ids = current_fund_ids - new_fund_ids
    update_ids = current_fund_ids & new_fund_ids
    create_ids = new_fund_ids - current_fund_ids

    #puts "New Fund Ids : #{new_fund_ids}"
    #puts "Current Fund Ids : #{current_fund_ids}"
    #puts "Deactivate Ids : #{deactivate_ids}"
    #puts "Update Fund Ids : #{update_ids}"
    #puts "Create Fund Ids : #{create_ids}"

    deactivate_allocation(multi_holding_allocations.select{|x| deactivate_ids.include?(x[:fund_ticker_id])})
    update_allocation(array.select{|x| update_ids.include?(x[:fund_ticker_id])})
    allocate(array.select{|x| create_ids.include?(x[:fund_ticker_id])})
    self.reload
    self.update_investments
  end


  def find_alloc_by_fund_ticker_id(id)
     multi_holding_allocations.select{|x| x.fund_ticker_id == id}.first
  end

  def has_price?
    false
  end

  def last_known_value
    multi_statements.last.try('ending_balance')
  end

  def todays_value
    est_current_value
  end

  def total_value
    est_current_value
  end

  def total_value_gain
    est_current_gain
  end

  def est_current_value
    sum = 0
    multi_holding_allocations.each do |mha|
      sum += mha.est_current_value
    end
    sum
  end

  def est_current_gain
    est_current_value - net_investment
  end

  def purchased_at
    if self.multi_statements.size > 0
      date = self.multi_statements.sort_by(&:started_on).first.started_on
      return date.nil? ? Time.now : date.to_time
    else
      Time.now
    end
  end


  def as_json(options={})
    result = super(options)
    result['last_known_value'] = self.last_known_value
    result['est_current_value'] = self.est_current_value
    result['est_current_gain'] = self.est_current_gain
    result
  end




  def populate_points
    past_values = self.get_past_values
    past_value_gains = self.get_past_value_gains
    past_value_gain_ratios = self.get_past_value_gain_ratios
    Point.names.each do |n|
      self.send("#{n}_value=", past_values[n])
      self.send("#{n}_value_gain=", past_value_gains[n])
      self.send("#{n}_gain_ratio=", past_value_gain_ratios[n])
    end
    self.points_updated_at = Date.today
    self.save
  end


end
