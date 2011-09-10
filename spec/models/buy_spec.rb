require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe Buy do

  context :populate_data do
    let(:buy){Factory :buy}
    it 'should populate investment' do
      buy.investment.should == (buy.price * buy.shares)
    end
  end
end
