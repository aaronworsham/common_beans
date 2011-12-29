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
                  :starting_quantity => 1
      bond.present_value.should == 885.3
    end
    it "should have a present value of 926.4 after 5 years in on the bond maturity" do
      bond = Factory :bond_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 5.years.from_now,
                  :purchased_at => 5.years.ago,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :starting_quantity => 1
      bond.present_value.should == 926.4
    end
    it "should have a present value of 8853.0 for 10 bonds" do
      bond = Factory :bond_holding,
                  :face_value => 1000,
                  :purchase_price => 1000,
                  :matures_at => 10.years.from_now,
                  :expected_yield => 0.12,
                  :coupon => 0.1,
                  :frequency => 2,
                  :starting_quantity => 10
      bond.present_value.should == 8853.0
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
                  :starting_quantity => 1
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
                  :starting_quantity => 1
      bond.present_value.should == 883.83
    end
  end

  context :total_return do
    before(:each) do
      @bond = Factory :bond_holding,
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
      @bond.num_coupons_paid.should == 10
    end
    it "should have a total_return coupons of 500" do
      @bond.total_return.should == 500
    end
  end

  context :sells do
    before(:each) do
      @bond = Factory :bond_holding,
              :face_value => 1000,
              :purchase_price => 885.3,
              :matures_at => 5.years.from_now,
              :purchased_at => 5.year.ago,
              :expected_yield => 0.12,
              :coupon => 0.1,
              :frequency => 2,
              :starting_quantity => 10

      @sell = Factory :bond_sell,
              :bond_holding => @bond,
              :user => @bond.user,
              :quantity => 1,
              :price  => 1000
    end

    it 'should reduce the quantity by 1' do
      @sell.quantity.should == 1
      @bond.starting_quantity.should == 10
      @bond.reload.net_quantity.should == 9
    end
    it 'should have a present value of 8337.6 because we only have 9 bonds' do
      @bond.present_value.should == 8337.6
    end
    it 'should have a net_investment of 8853.0' do
      @bond.net_investment.should == 8853.0
    end
    it 'should have a net_return of 1,000 because we sold one bond' do
      @bond.net_return.should == 1000.0
    end
    it 'should have a total return of 1500 because we sold one bond and collected 500 in interest' do
      @bond.total_return.should == 1500.0
    end
    it 'should have a total gain of 984.6' do
      @bond.total_gain.should == 984.6
    end

  end


end