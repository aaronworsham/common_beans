require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Sell do

  context :populate_data do
    let(:sell){Factory :sell}
    it 'should populate investment' do
      sell.return.should == (sell.price * sell.shares)
    end
  end
end
