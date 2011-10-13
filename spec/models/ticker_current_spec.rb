require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe TickerCurrent do
  before(:each) do
    @response = {"symbol"=>"GOOG", "name"=>"Google Inc.", "lastTrade"=>554.88, "date"=>"10/13/2011", "time"=>"2:55pm", "change"=>"+6.38 - +1.16%", "changePoints"=>6.38, "changePercent"=>1.16, "previousClose"=>548.5, "open"=>550.95, "dayHigh"=>556.45, "dayLow"=>548.02, "volume"=>2878727, "dayRange"=>"548.02 - 556.45", "lastTradeWithTime"=>"2:55pm - <b>554.88</b>", "tickerTrend"=>"&nbsp;-=-+-=&nbsp;", "averageDailyVolume"=>3826290, "bid"=>554.83, "ask"=>555.06}
    @ticker = Ticker.find_by_symbol "GOOG"
    @tcurrent = TickerCurrent.new(:ticker => @ticker)

  end

  it "should accept a ticker as a param" do
    @tcurrent.ticker.should == @ticker
  end

  it "create method should ping tracker and return instance" do
    TickerCurrent.should_receive(:ping_tracker).and_return(@response)
    tc = TickerCurrent.create(@ticker)
    tc.lastTrade.should == 554.88
  end

end