require 'spec_helper'

feature "add fund to portfolio" do
  fixtures :fund_tickers, :fund_ticker_eods
  before(:each) do
    visit '/auth/twitter'
    FundHolding.any_instance.stub(:todays_price).and_return(100)
    FundHolding.any_instance.stub(:todays_value).and_return(1000)
    @portfolio = Factory :portfolio, :user => User.first, :name => 'Test'
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-holding[data-security-name=fund]')
    end
  end

  scenario 'create new fund' do
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
    @portfolio.reload
    @portfolio.fund_holdings.size.should == 1
    within('#portfolio-content-1 .fund-content') do
      page.should have_content('FDGRX')
      page.should have_content('10')
      page.should have_content('75.0')
    end
  end

  scenario 'validates for required information' do
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=fund]').click
    within('#new_fund_holding') do
      click_on('Create')
    end
    @portfolio.fund_holdings.size.should == 0
  end

end