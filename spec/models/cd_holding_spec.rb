require File.join(File.dirname(__FILE__), '..', 'spec_helper')
describe CdHolding do

  context :semi_annually do
    it "should have a present value of 885.3" do
      cd = Factory :cd_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :starting_quantity => 1
      cd.present_value.should == 885.3
    end
    it "should have a present value of 926.4 after 5 years in on the cd maturity" do
      cd = Factory :cd_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 5.years.from_now,
                  :purchased_at => 5.years.ago,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :starting_quantity => 1
      cd.present_value.should == 926.4
    end
    it "should have a present value of 8853.0 for 10 cds" do
      cd = Factory :cd_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :starting_quantity => 10
      cd.present_value.should == 8853.0
    end
  end
  context :annually do
    it "should have a present value of 887.0" do
      cd = Factory :cd_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 1,
                  :starting_quantity => 1
      cd.present_value.should == 887.0
    end
  end
  context :monthly do
    it "should have a present value of 883.83" do
      cd = Factory :cd_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 12,
                  :starting_quantity => 1
      cd.present_value.should == 883.83
    end
  end

  context :total_return do
    before(:each) do
      @cd = Factory :cd_holding,
            :face_value => 1000,
            :purchase_price => 1000,
            :matures_at => 5.years.from_now,
            :purchased_at => 5.years.ago,
            :expected_yield => 0.12,
            :coupon => 0.1,
            :frequency => 2,
            :starting_quantity => 1
    end
    it "should have paid 10 coupons" do
      @cd.num_coupons_paid.should == 10
    end
    it "should have a total_return coupons of 500" do
      p @cd.total_return.to_s
      @cd.total_return.should == 500
    end
  end


end