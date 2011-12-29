require 'spec_helper'

describe MultiHoldingAllocation do
  before(:each) do
    @multi = Factory  :multi_holding
    fund1 = Factory   :fund_ticker
    @alloc1 = Factory :multi_holding_allocation,
                      :fund_ticker => fund1,
                      :multi_holding => @multi,
                      :allocation_percentage => 50.0,
                      :contributions => 1000,
                      :distributions => 500,
                      :estimated_units => 100,
                      :current_state => 'inactive'
  end

  it 'percent contrib of 1000 should be 500' do
    @alloc1.percent_of_contribution(1000).should == 500
  end

  it 'should update contributions to 1500 with additional 1000 contribution based on percent' do
    @alloc1.percent_contrib_increase(1000)
    @alloc1.reload.contributions.should == 1500
  end
end
