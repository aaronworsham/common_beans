require 'spec_helper'

feature "add securities to portfolio" do
  fixtures :stock_tickers, :stock_ticker_eods,:etf_tickers, :etf_ticker_eods,:fund_tickers, :fund_ticker_eods
  before(:each) do
    visit '/auth/twitter'
    ['Cd','Stock','Bond','Etf','Fund'].each do |pre|
      Object.const_get("#{pre}Holding").any_instance.stub(:todays_price).and_return(100)
      Object.const_get("#{pre}Holding").any_instance.stub(:todays_value).and_return(1000)
    end
    Portfolio.stub(:compare_indices_for_user).and_return([])
    @portfolio = Factory :portfolio, :user => User.first, :name => 'Test'
  end

  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-holding[data-security-name=fund]')
      page.should have_css('a.add-holding[data-security-name=stock]')
      page.should have_css('a.add-holding[data-security-name=etf]')
      page.should have_css('a.add-holding[data-security-name=cd]')
      page.should have_css('a.add-holding[data-security-name=bond]')
    end
  end
  
  scenario 'create new securities' do
    @portfolio.stock_holdings.size.should == 0
    visit '/dashboard'
    find('.overview a.add-holding[data-security-name=stock]').click
    within('#new_stock_holding') do
      fill_in 'stock_holding_ticker_name', :with => 'Google'
    end
    find('.ui-autocomplete li:first a').click
    within('#new_stock_holding') do
      fill_in 'stock_holding_starting_shares', :with => '10'
      fill_in 'stock_holding_starting_price', :with => '7.50'
      select '2012', :from => 'stock_holding[purchased_at(1i)]'
      select 'January', :from => 'stock_holding[purchased_at(2i)]'
      select '16', :from => 'stock_holding[purchased_at(3i)]'
      click_on('Create')
    end
    @portfolio.fund_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=fund]').click
    within('#new_fund_holding') do
      fill_in 'fund_holding_ticker_name', :with => 'Fidelity Growth Co'
    end
    find('.ui-autocomplete li:first a').click
    within('#new_fund_holding') do
      fill_in 'fund_holding_starting_units', :with => '10'
      fill_in 'fund_holding_starting_price', :with => '7.50'
      select '2012', :from => 'fund_holding_purchased_at_1i'
      select 'January', :from => 'fund_holding_purchased_at_2i'
      select '16', :from => 'fund_holding_purchased_at_3i'
      click_on('Create')
    end
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
    @portfolio.cd_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=cd]').click
    within('#new_cd_holding') do
      fill_in 'cd_holding_name', :with => 'Fidelity Growth Co'
    end
    within('#new_cd_holding') do
      fill_in 'cd_holding_cusip', :with => '345370860'
      select '2012', :from => 'cd_holding_purchased_at_1i'
      select 'January', :from => 'cd_holding_purchased_at_2i'
      select '16', :from => 'cd_holding_purchased_at_3i'
      select '2017', :from => 'cd_holding_matures_at_1i'
      select 'January', :from => 'cd_holding_matures_at_2i'
      select '16', :from => 'cd_holding_matures_at_3i'
      fill_in 'cd_holding_coupon', :with => '.1'
      fill_in 'cd_holding_purchase_price', :with => '1000'
      fill_in 'cd_holding_starting_quantity', :with => '1'
      fill_in 'cd_holding_frequency', :with => '2'
      fill_in 'cd_holding_face_value', :with => '1000'
      fill_in 'cd_holding_expected_yield', :with => '0.12'
      click_on('Create')
    end
    @portfolio.etf_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=etf]').click
    within('#new_etf_holding') do
      fill_in 'etf_holding_ticker_name', :with => 'United States Oil'
    end
    find('.ui-autocomplete li:first a').click
    within('#new_etf_holding') do
      fill_in 'etf_holding_starting_units', :with => '10'
      fill_in 'etf_holding_starting_price', :with => '7.50'
      select '2012', :from => 'etf_holding_purchased_at_1i'
      select 'January', :from => 'etf_holding_purchased_at_2i'
      select '16', :from => 'etf_holding_purchased_at_3i'
      click_on('Create')
    end
  @portfolio.reload
  @portfolio.stock_holdings.size.should == 1
  within('#portfolio-content-1 .fund-content') do
    page.should have_content('FDGRX')
    page.should have_content('10')
    page.should have_content('75.0')
  end
  @portfolio.fund_holdings.size.should == 1
  within('#portfolio-content-1 .stock-content') do
    page.should have_content('GOOG')
    page.should have_content('10')
    page.should have_content('75.0')
  end
  @portfolio.bond_holdings.size.should == 1
  within('#portfolio-content-1 .bond-content') do
    page.should have_content('')
    page.should have_content('')
    page.should have_content('1000')
  end
  @portfolio.cd_holdings.size.should == 1
  within('#portfolio-content-1 .cd-content') do
    page.should have_content('')
    page.should have_content('')
    page.should have_content('1000')
  end
  @portfolio.etf_holdings.size.should == 1
  within('#portfolio-content-1 .etf-content') do
    page.should have_content('USO')
    page.should have_content('10')
    page.should have_content('75.0')
  end
  end
  
  scenario 'validates for required information' do
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=stock]').click
    within('#new_stock_holding') do
      click_on('Create')
    end
    @portfolio.stock_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=fund]').click
    within('#new_fund_holding') do
      click_on('Create')
    end
    @portfolio.fund_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=bond]').click
    within('#new_bond_holding') do
      click_on('Create')
    end
    @portfolio.bond_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=cd]').click
    within('#new_cd_holding') do
      click_on('Create')
    end
    @portfolio.cd_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=etf]').click
    within('#new_etf_holding') do
      click_on('Create')
    end
    @portfolio.etf_holdings.size.should == 0
  end
end