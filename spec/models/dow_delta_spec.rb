require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe DowIndex do
  fixtures :dow_index_eods

  it 'should have todays close as $10' do
    DowIndex.todays_close.should == 10.0
  end

  it 'should return a number of shares of 100 for $1000 investment with dow_eod close at $10' do
    DowIndex.number_of_shares(1000.0, (Factory :dow_index_eod, :close => 10.0)).should == 100
  end

  it 'should return todays value of 100 shares as $1000' do
    DowIndex.todays_value(100).should == 1000.0
  end


  it 'should show an investment delta of $1000 from t0[100 shares, price $10, dow_eod $5] and t1[price 20, dow $10]' do
    DowIndex.investment_delta(
                                :starting_investment => 1000.0,
                                :todays_value => 3000.0,
                                :dow_eod => (Factory :dow_index_eod, :close => 5.0)
                              ).should == 1000.0
  end

end