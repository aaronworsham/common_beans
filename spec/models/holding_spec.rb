require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Holding do

  context :populate_data do
    let(:holding){ Factory :holding, :starting_shares => 1000, :starting_price => 10 }
    it 'should have the investment populated by default' do
      holding.starting_investment.should == (holding.starting_shares * holding.starting_price)
    end

    it 'should have a zero return by default' do
      holding.net_return.should == 0
    end

    context :sells do
      let(:sell){
        Factory :sell, 
                :holding => holding, 
                :user => holding.user,
                :ticker => holding.ticker,
                :shares => 100,
                :price  => 10


      }

      it 'should reduce the net shares by 100 to sell 100 shares' do
        sell.shares.should == 100
        holding.starting_shares.should == 1000
        holding.reload.net_shares.should == (holding.starting_shares - sell.shares)
      end

      it 'should up the return to 1000' do
        sell.return_on_investment.should == (sell.shares * sell.price)
        sell.return_on_investment.should === 1000.0
        holding.net_return.should === 1000.0
        holding.net_return.should == (sell.shares * sell.price)
      end

    end

    context :buys do
      let(:buy){
        Factory :buy, 
                :holding => holding, 
                :user => holding.user,
                :ticker => holding.ticker,
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
      let(:holding){Factory :holding, :starting_shares => 2000, :starting_price => 10}
      before(:each) do
        Factory :buy, 
                :holding => holding, 
                :user => holding.user,
                :ticker => holding.ticker,
                :shares => 200,
                :price  => 10        
        Factory :sell, 
                :holding => holding, 
                :user => holding.user,
                :ticker => holding.ticker,
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

  describe "builds an Index" do
    context 'Dow' do
      fixtures :dow_index_eods
      fixtures :tickers
      fixtures :ticker_eods
      before(:each) do
        @holding = Factory  :holding,
                            :ticker => Ticker.first, #google
                            :date_of_purchase => '2011/02/01',
                            :starting_shares => 500,
                            :starting_price => 611.04,
                            :dow_index_eod => DowIndexEod.first
      end

      it 'should have a Dow Index EOD assigned on create' do
        @holding.reload
        @holding.dow_index_eod.should be
      end

      it 'should have a starting investment of 305520' do
        @holding.starting_investment.should == 305520.0
      end

      it 'has an dow investment delta 35140.77' do
        @holding.dow_delta.to_f.round(2).should == -18029.23
      end

      context 'with buy' do
        before(:each) do
          @buy = Factory  :buy,
                          :ticker => Ticker.first, #google
                          :holding => @holding,
                          :date_of_event => '03/01/2011',
                          :price => 600.76,
                          :shares => 100,
                          :dow_index_eod => DowIndexEod.all[2]
        end

        it 'should have an dow investment delta of 29823.44' do
          @holding.dow_delta.to_f.round(2).should == 29823.44
        end

      end
    end
  end
end
