require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe 'Tickers' do
  fixtures :stock_tickers
  fixtures :stock_ticker_eods


  describe StockTicker do


    before(:each) do
      @ticker = StockTicker.find_by_symbol('GOOG')


    end

    it ' todays close price should be 633.14 as per mock results' do
      @ticker.expects(:current_quote).returns(StockTracker::MockCurrentQuote.new('GOOG'))
      @ticker.todays_close.should == 633.14
    end

    context :past_quote do

      before(:each) do
        @date = Date.parse('01/10/2010')
        @ticker.local_eod_by_date(@date).try('delete')
        @ticker.expects(:past_quote).with(@date).returns(StockTracker::MockPastQuote.new('GOOG', Date.today))
        @eod_num = StockTickerEod.count
        @close = @ticker.close_for_date(@date)
      end

      it ' will create an EOD for past quote ' do
        StockTickerEod.count.should == (@eod_num + 1)
      end

      it ' will have a close cost of 630.37 per mock results' do
        @close.to_f.should == 630.37
      end

    end
  end


end