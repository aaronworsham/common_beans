require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe FundHolding do

  context :populate_data do
    let(:holding){ Factory :fund_holding, :starting_units => 1000, :starting_price => 10 }
    it 'should have the investment populated by default' do
      holding.starting_investment.should == 10000.0
    end

    it 'should have a zero return by default' do
      holding.net_return.should == 0
    end

    context :current_price do
      before(:each) do
        FundHolding.any_instance.stub(:todays_price).and_return(20)
      end

      it 'should have a value of 20000' do
        holding.todays_value.should == 20000.0
      end

      it 'should have a gain of 10000' do
        holding.total_gain.should == 10000.0
      end
    end

    context :sells do
      let(:sell){
        Factory :fund_sell,
                :fund_holding => holding,
                :user => holding.user,
                :fund_ticker => holding.ticker,
                :units => 100,
                :price  => 10


      }

      it 'should reduce the net units by 100 to sell 100 units' do
        sell.units.should == 100
        holding.starting_units.should == 1000
        holding.reload.net_units.should == (holding.starting_units - sell.units)
      end

      it 'should up the return to 1000' do
        sell.roi.should == (sell.units * sell.price)
        sell.roi.should === 1000.0
        holding.net_return.should === 1000.0
        holding.net_return.should == (sell.units * sell.price)
      end

    end

    context :buys do
      let(:buy){
        Factory :fund_buy,
                :fund_holding => holding,
                :user => holding.user,
                :fund_ticker => holding.ticker,
                :units => 100,
                :price  => 10


      }

      it 'should increase the net units by 100 to buy 100 units' do
        buy.units.should == 100
        holding.starting_units.should == 1000
        holding.reload.net_units.should == (holding.starting_units + buy.units)
      end

      it 'should up the investment to 11000' do
        buy.investment.should == (buy.units * buy.price)
        buy.investment.should === 1000.0
        holding.net_investment.should === 11000.0
        holding.net_investment.should == ((buy.units * buy.price) +  holding.starting_investment)
      end

    end

    context :buy_and_sell do
      let(:holding){Factory :fund_holding, :starting_units => 2000, :starting_price => 10}
      before(:each) do
        Factory :fund_buy,
                :fund_holding => holding,
                :user => holding.user,
                :fund_ticker => holding.ticker,
                :units => 200,
                :price  => 10        
        Factory :fund_sell,
                :fund_holding => holding,
                :user => holding.user,
                :fund_ticker => holding.ticker,
                :units => 300,
                :price  => 10
      end
      it 'should increase return and investment' do
        holding.net_investment.should === 22000.0
        holding.net_return.should == 3000
        holding.net_units.should == 1900
      end
    end
  end
end
