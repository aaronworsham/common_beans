require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe BondHolding do

  context :semi_annually do
    it "should have a present value of 885.3" do
      bond = Factory :bond_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :quantity => 1
      bond.present_value.should == 885.3
    end
  end
  context :annually do
    it "should have a present value of 887.0" do
      bond = Factory :bond_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 1,
                  :quantity => 1
      bond.present_value.should == 887.0
    end
  end
  context :monthly do
    it "should have a present value of 883.83" do
      bond = Factory :bond_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 12,
                  :quantity => 1
      bond.present_value.should == 883.83
    end
  end


end