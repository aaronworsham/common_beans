require 'spec_helper'

describe MultiHolding do
  describe :new do
    before(:each) do
      @multi = Factory  :multi_holding
      @fund1 = Factory   :fund_ticker
      @fund2 = Factory   :fund_ticker
      @fund3 = Factory   :fund_ticker
      @alloc1 = Factory :multi_holding_allocation,
                        :fund_ticker => @fund1,
                        :multi_holding => @multi,
                        :allocation_percentage => 50.0,
                        :estimated_units => 100,
                        :current_state => 'inactive'
      @multi.reload
      @alloc2 = Factory :multi_holding_allocation,
                        :fund_ticker => @fund2,
                        :multi_holding => @multi,
                        :allocation_percentage => 50.0,
                        :estimated_units => 100
      @multi.reload
      @alloc3 = Factory :multi_holding_allocation,
                        :fund_ticker => @fund3,
                        :multi_holding => @multi,
                        :allocation_percentage => 50.0,
                        :estimated_units => 100
      @multi.update_investments
      @multi.reload
    end

    it 'should have 3 total allocations' do
      @multi.multi_holding_allocations.count.should == 3
    end
    it 'should have 2 active allocations' do
      @multi.multi_holding_allocations.active.count.should == 2
    end
    it 'should have 100% allocation' do
      @multi.percent_allocated.should == 100
    end
  end

  describe :reallocation  do
    before(:each) do
      @multi = Factory  :multi_holding
      @fund1 = Factory   :fund_ticker
      @fund2 = Factory   :fund_ticker
      @fund3 = Factory   :fund_ticker
      @alloc1 = Factory :multi_holding_allocation,
                        :fund_ticker => @fund1,
                        :multi_holding => @multi,
                        :allocation_percentage => 50.0,
                        :estimated_units => 100
      @multi.reload
      @alloc2 = Factory :multi_holding_allocation,
                        :fund_ticker => @fund2,
                        :multi_holding => @multi,
                        :allocation_percentage => 50.0,
                        :estimated_units => 100
      @multi.reload
      @allocation = [
        {
          :fund_ticker_id => @fund2.id,
          :allocation => 30.0,
          :contributions => 1000
        },
        {
          :fund_ticker_id => @fund3.id,
          :allocation => 70.0,
          :contributions => 1000
        }

      ]
      @multi.reallocate(@allocation)
      @multi.reload
    end

    it 'will create a third allocation for fund3' do
      @multi.multi_holding_allocations.count.should == 3
      @multi.multi_holding_allocations.last.fund_ticker.should == @fund3
    end

    it 'will deactivate fund1' do
      @multi.multi_holding_allocations.active.count.should == 2
      @multi.multi_holding_allocations.first.fund_ticker.should == @fund1
    end

    it 'total allocation percentage will be 100, with a 70/30 split' do
      @multi.percent_allocated.should == 100.0
      @multi.multi_holding_allocations.active.first.allocation_percentage.should == 30.0
    end

  end

end
