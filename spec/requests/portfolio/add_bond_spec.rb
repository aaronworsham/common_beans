require 'spec_helper'

feature "add bond to portfolio" do
    before(:each) do
    visit '/auth/twitter'
    BondHolding.any_instance.stub(:todays_price).and_return(100)
    BondHolding.any_instance.stub(:todays_value).and_return(1000)
    @portfolio = Factory :portfolio, :user => User.first, :name => 'Test'
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-holding[data-security-name=bond]')
    end
  end

scenario 'create new bond' do
    @portfolio.bond_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=bond]').click
    within('#new_bond_holding') do
      fill_in 'bond_holding_name', :with => 'Fidelity Growth Co'
    end
    within('#new_bond_holding') do
      fill_in 'bond_holding_cusip', :with => '345370860'
      select '2012', :from => 'bond_holding_purchased_at_1i'
      select 'January', :from => 'bond_holding_purchased_at_2i'
      select '16', :from => 'bond_holding_purchased_at_3i'
      select '2017', :from => 'bond_holding_matures_at_1i'
      select 'January', :from => 'bond_holding_matures_at_2i'
      select '16', :from => 'bond_holding_matures_at_3i'
      fill_in 'bond_holding_coupon', :with => '.1'
      fill_in 'bond_holding_purchase_price', :with => '1000'
      fill_in 'bond_holding_starting_quantity', :with => '1'
      fill_in 'bond_holding_frequency', :with => '2'
      fill_in 'bond_holding_face_value', :with => '1000'
      fill_in 'bond_holding_expected_yield', :with => '0.12'
      click_on('Create')
    end
    @portfolio.reload
    @portfolio.bond_holdings.size.should == 1
    within('#portfolio-content-1 .bond-content') do
      page.should have_content('')
      page.should have_content('')
      page.should have_content('1000')
    end
  end

scenario 'validates for required information' do
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=bond]').click
    within('#new_bond_holding') do
      click_on('Create')
    end
    @portfolio.bond_holdings.size.should == 0
  end

end