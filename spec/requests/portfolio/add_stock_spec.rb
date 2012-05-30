require 'spec_helper'

feature "add stock to portfolio" do
  fixtures :stock_tickers, :stock_ticker_eods
  before(:each) do
    visit '/auth/twitter'
    StockHolding.any_instance.stub(:todays_price).and_return(100)
    StockHolding.any_instance.stub(:todays_value).and_return(1000)
    Portfolio.stub(:compare_indices_for_user).and_return([])
    @portfolio = Factory :portfolio, :user => User.first, :name => 'Test'
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-holding[data-security-name=stock]')
    end
  end

  scenario 'create new stock' do
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
    @portfolio.reload
    @portfolio.stock_holdings.size.should == 1
    within('#portfolio-content-1 .stock-content') do
      page.should have_content('GOOG')
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
  end

end