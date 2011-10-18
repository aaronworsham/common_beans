require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Ticker do
  fixtures :tickers
  fixtures :ticker_eods

  before(:each) do
    @ticker = Ticker.first
  end

  it ' todays close price should be $10' do
    @ticker.todays_close.should > 0
  end

  context :past_quote do

    before(:each) do
      @eod_num = TickerEod.count
      @close = @ticker.close_for_date('01/10/2010')
    end

    it ' will create an EOD for past quote ' do
      @eod_num.should == (TickerEod.count - 1)
    end

    it ' will have a close cost of 525.62' do
      @close.should == 525.62
    end

  end


end