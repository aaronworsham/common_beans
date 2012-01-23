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

  Timecop.freeze(Date.parse('2012-01-23')) do
    describe 'past values' do
      fixtures :stock_tickers
      fixtures :stock_ticker_eods
      before(:each) do
        @ticker = StockTicker.find_by_symbol 'GOOG'
        @holding = Factory :stock_holding,
                           :starting_shares => 1000,
                           :starting_price => 10,
                           :stock_ticker => @ticker
        @holding.populate_eod
        @holding.reload
      end
      it 'should have a d7 of 624.99' do
          @holding.d7_price.should == 624.99
      end
      it 'should have a d7_value of 624990.00' do
          @holding.d7_value.should == 624990.00
      end
      it 'should have a d30 of 633.14' do
        @holding.d30_price.should == 633.14
      end
      it 'should have a d30_value of 633140.00' do
        @holding.d30_value.should == 633140.00
      end
      it 'should have a d180 of 607.22' do
        @holding.d180_price.should == 607.22
      end
      it 'should have a d180_value of 607220.00' do
        @holding.d180_value.should == 607220.00
      end
      it 'should have a d365 of 611.83' do
        @holding.d365_price.should == 611.83
      end
      it 'should have a d365_value of 611830.00' do
        @holding.d365_value.should == 611830.00
      end
      it 'should have a y2 of 550.01' do
        @holding.y2_price.should == 550.01
      end
      it 'should have a y2_value of 550010.00' do
        @holding.y2_value.should == 550010.00
      end
      it 'should have a y3 of 324.7' do
        @holding.y3_price.should == 324.7
      end
      it 'should have a y3 of 324700.00' do
        @holding.y3_value.should == 324700.00
      end
      it 'should have a y4 of 548.62' do
        @holding.y4_price.should == 548.62
      end
      it 'should have a y4_value of 548620.00' do
        @holding.y4_value.should == 548620.00
      end
      it 'should have a y5 of 479.05' do
        @holding.y5_price.should == 479.05
      end
      it 'should have a y5_value of 479050.00' do
        @holding.y5_value.should == 479050.00
      end
    end
  end



end
