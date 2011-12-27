require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe StockHolding do

  context :populate_data do
    let(:holding){ Factory :stock_holding, :starting_shares => 1000, :starting_price => 10 }
    it 'should have the investment populated by default' do
      holding.starting_investment.should == (holding.starting_shares * holding.starting_price)
    end

    it 'should have a zero return by default' do
      holding.net_return.should == 0
    end

    context :sells do
      let(:sell){
        Factory :stock_sell,
                :stock_holding => holding,
                :user => holding.user,
                :stock_ticker => holding.ticker,
                :shares => 100,
                :price  => 10


      }

      it 'should reduce the net shares by 100 to sell 100 shares' do
        sell.shares.should == 100
        holding.starting_shares.should == 1000
        holding.reload.net_shares.should == (holding.starting_shares - sell.shares)
      end

      it 'should up the return to 1000' do
        sell.roi.should == (sell.shares * sell.price)
        sell.roi.should === 1000.0
        holding.net_return.should === 1000.0
        holding.net_return.should == (sell.shares * sell.price)
      end

    end

    context :buys do
      let(:buy){
        Factory :stock_buy,
                :stock_holding => holding,
                :user => holding.user,
                :stock_ticker => holding.ticker,
                :shares => 100,
                :price  => 10


      }

      it 'should increase the net shares by 100 to buy 100 shares' do
        buy.shares.should == 100
        holding.starting_shares.should == 1000
        holding.reload.net_shares.should == (holding.starting_shares + buy.shares)
      end

      it 'should up the investment to 11000' do
        buy.investment.should == (buy.shares * buy.price)
        buy.investment.should === 1000.0
        holding.net_investment.should === 11000.0
        holding.net_investment.should == ((buy.shares * buy.price) +  holding.starting_investment)
      end

    end

    context :buy_and_sell do
      let(:holding){Factory :stock_holding, :starting_shares => 2000, :starting_price => 10}
      before(:each) do
        Factory :stock_buy,
                :stock_holding => holding,
                :user => holding.user,
                :stock_ticker => holding.ticker,
                :shares => 200,
                :price  => 10        
        Factory :stock_sell,
                :stock_holding => holding,
                :user => holding.user,
                :stock_ticker => holding.ticker,
                :shares => 300,
                :price  => 10
      end
      it 'should increase return and investment' do
        holding.net_investment.should === 22000.0
        holding.net_return.should == 3000
        holding.net_shares.should == 1900
      end
    end
  end
end
