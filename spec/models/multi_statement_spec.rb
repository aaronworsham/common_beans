require 'spec_helper'

describe MultiStatement do
  before(:each) do
    @multi = Factory  :multi_holding
    @fund1 = Factory   :fund_ticker
    @fund2 = Factory   :fund_ticker
    @fund3 = Factory   :fund_ticker

    @fund1.stubs(:close_for_date).with(3.months.ago.to_date).returns(10.0)
    @fund2.stubs(:close_for_date).with(3.months.ago.to_date).returns(15.0)


    @statement = Factory :multi_statement,
                         :multi_holding => @multi,
                         :started_on => 4.months.ago.to_date,
                         :starting_balance => 10000,
                         :ended_on => 3.months.ago.to_date,
                         :ending_balance => 12000,
                         :contributions => 2000,
                         :multi_statement_allocations_attributes => [
                            {
                              :fund_ticker => @fund1,
                              :allocation_percentage => 50.0
                            },
                            {
                              :fund_ticker => @fund2,
                              :allocation_percentage => 50.0
                            }
                         ]
    @statement.reload
    @multi.reload
  end

  it 'should have 2 statement allocation after create' do
    @statement.multi_statement_allocations.count.should == 2
  end

  it 'should have 2 holding allocations after create' do
    @multi.multi_holding_allocations.count.should == 2
  end

  it 'should have first holding allocations estimated units of 600' do
    @multi.multi_holding_allocations.first.estimated_units.should == 600
  end
  it 'should have last holding allocations estimated units of 400' do
    @multi.multi_holding_allocations.last.estimated_units.should == 400
  end

  it 'should have first statement allocation pointing to fund2' do
    @statement.multi_statement_allocations.first.fund_ticker.should == @fund1
  end

  it 'should have first statement allocation contribution of 1000' do
    @statement.multi_statement_allocations.first.contributions.should == 1000
  end

  it 'multi should have a net_investment of 2000' do
    @multi.net_investment.should == 2000
  end

  it 'first statement allocation will have estimated units of 600' do
    @statement.multi_statement_allocations.first.estimated_units.should == 600
  end

  it 'second statement allocation will have estimated units of 400' do
    @statement.multi_statement_allocations.last.estimated_units.should == 400
  end
  #

  context :second_statement do
    before(:each) do
    @fund2.stubs(:close_for_date).with(2.months.ago.to_date).returns(15.0)
    @fund3.stubs(:close_for_date).with(2.months.ago.to_date).returns(20.0)
      @statement2 = Factory :multi_statement,
                     :multi_holding => @multi,
                     :started_on => 3.months.ago.to_date,
                     :starting_balance => 12000,
                     :ended_on => 2.months.ago.to_date,
                     :ending_balance => 13000,
                     :contributions => 1000,
                     :multi_statement_allocations_attributes => [
                        {
                          :fund_ticker => @fund2,
                          :allocation_percentage => 30.0,
                        },
                        {
                          :fund_ticker => @fund3,
                          :allocation_percentage => 70.0,
                        }
                     ]
    end

    it 'should have 2 statement allocation after create' do
      @statement2.multi_statement_allocations.count.should == 2
    end

    it 'should have 3 holding allocations after create' do
      @multi.multi_holding_allocations.count.should == 3
    end
    it 'should have first holding allocations estimated units of 0' do
      @multi.multi_holding_allocations.first.estimated_units.should == 0
    end
    it 'should have first holding allocations estimated units of 260' do
      @multi.multi_holding_allocations.active.first.estimated_units.should == 260
    end
    it 'should have last holding allocations estimated units of 455' do
      @multi.multi_holding_allocations.active.last.estimated_units.should == 455
    end
    it 'should have 2 active holding allocations after create' do
      @multi.multi_holding_allocations.active.count.should == 2
    end

    it 'should have first statement allocation pointing to fund2' do
      @statement2.multi_statement_allocations.first.fund_ticker.should == @fund2
    end

    it 'multi should have a net_investment of 3000' do
      @multi.net_investment.should == 3000
    end

    it 'first statement allocation will have estimated units of 260' do
      @statement2.multi_statement_allocations.first.estimated_units.should == 260
    end

    it 'second statement allocation will have estimated units of 455' do
      @statement2.multi_statement_allocations.last.estimated_units.should == 455
    end

      context :third_statement do
        before(:each) do
          @fund2.stubs(:close_for_date).with(1.month.ago.to_date).returns(20.0)
          @fund3.stubs(:close_for_date).with(1.month.ago.to_date).returns(25.0)
          @statement3 = Factory :multi_statement,
                         :multi_holding => @multi,
                         :started_on => 2.months.ago.to_date,
                         :starting_balance => 13000,
                         :ended_on => 1.months.ago.to_date,
                         :ending_balance => 14000,
                         :contributions => 1000,
                         :multi_statement_allocations_attributes => [
                            {
                              :fund_ticker => @fund2,
                              :allocation_percentage => 30.0,
                            },
                            {
                              :fund_ticker => @fund3,
                              :allocation_percentage => 70.0,
                            }
                         ]
        end

        it 'should have 2 statement allocation after create' do
          @statement3.multi_statement_allocations.count.should == 2
        end

        it 'should have 3 holding allocations after create' do
          @multi.multi_holding_allocations.count.should == 3
        end
        it 'should have first holding allocations estimated units of 0' do
          @multi.multi_holding_allocations.first.estimated_units.should == 0
        end
        it 'should have first holding allocations estimated units of 210' do
          @multi.multi_holding_allocations.active.first.estimated_units.should == 210
        end
        it 'should have last holding allocations estimated units of 392' do
          @multi.multi_holding_allocations.active.last.estimated_units.should == 392
        end
        it 'should have 2 active holding allocations after create' do
          @multi.multi_holding_allocations.active.count.should == 2
        end

        it 'should have first statement allocation pointing to fund2' do
          @statement3.multi_statement_allocations.first.fund_ticker.should == @fund2
        end

        it 'multi should have a net_investment of 4000' do
          @multi.net_investment.should == 4000
        end
        it 'first statement allocation will have estimated units of 210' do
          @statement3.multi_statement_allocations.first.estimated_units.should == 210
        end

        it 'second statement allocation will have estimated units of 392' do
          @statement3.multi_statement_allocations.last.estimated_units.should == 392
        end
        #

      end
  end


end
