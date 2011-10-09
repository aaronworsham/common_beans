require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Buy do
  fixtures :dow_index_eods
  fixtures :tickers
  fixtures :ticker_eods

  context :populate_data do
    let(:buy){Factory :buy}
    it 'should populate investment' do
      buy.investment.should == (buy.price * buy.shares)
    end
  end

  context :dow do
    before(:each) do
      @holding = Factory  :holding,
                          :ticker => Ticker.first, #google
                          :dow_index_eod => DowIndexEod.first

      @buy = Factory  :buy,
                      :holding => @holding,
                      :ticker => Ticker.first, #google
                      :date_of_event => '03/01/2011',
                      :price => 600.76,
                      :shares => 100,
                      :dow_index_eod => DowIndexEod.all[2]
    end
    it 'should have a dow_eod' do
      @buy.dow_index_eod.should be
    end
    it 'should return an investment delta' do
      @buy.dow_delta.to_f.round(2).should == -2617.33
    end
  end

end
