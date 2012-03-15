require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe 'Tickers' do
  fixtures :stock_tickers
  fixtures :stock_ticker_eods

  Timecop.freeze(Date.parse('23/01/2012')) do

    describe StockTicker do

      before(:each) do
        @ticker = StockTicker.find_by_symbol('GOOG')


      end

      it ' todays close price should be 633.14 as per mock results' do
        @ticker.expects(:current_quote).returns(StockTracker::MockCurrentQuote.new('GOOG'))
        @ticker.todays_close.should == 633.14
      end

      context :past_quote do

        it 'should have a d7 of 624.99' do
          @ticker.d7_close.should == 624.99
        end
        it 'should have a d30 of 633.14' do
          @ticker.d30_close.should == 633.14
        end
        it 'should have a d180 of 607.22' do
          @ticker.d180_close.should == 607.22
        end
        it 'should have a d365 of 611.83' do
          @ticker.d365_close.should == 611.83
        end
        it 'should have a y2 of 550.01' do
          @ticker.y2_close.should == 550.01
        end
        it 'should have a y3 of 324.7' do
          @ticker.y3_close.should == 324.7
        end
        it 'should have a y4 of 548.62' do
          @ticker.y4_close.should == 548.62
        end
        it 'should have a y5 of 479.05' do
          @ticker.y5_close.should == 479.05
        end


      end
    end
  end
end