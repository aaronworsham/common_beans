require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Ticker do
  fixtures :tickers
  fixtures :ticker_eods

  before(:each) do
    @ticker = Ticker.first
  end

  it ' todays close price should be $10' do
    @ticker.todays_close.should == 20.0
  end

  it 'should have two eods' do
    @ticker.ticker_eods.count.should == 2
  end
end