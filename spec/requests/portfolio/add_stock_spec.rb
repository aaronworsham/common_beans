require 'spec_helper'

feature "add stock to portfolio" do
  fixtures :stock_tickers
  before(:each) do
    visit '/auth/twitter'
    @portfolio = Factory :portfolio, :user => User.first
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-stock')
    end
  end

  scenario 'create new stock' do
    @portfolio.stock_holdings.size.should == 0
    visit '/dashboard'
    find('.portfolio-content a.add-stock').click
    within('#new_stock_holding') do
      fill_in 'stock_holding_ticker_name', :with => 'Apple'
    end
    find('.ui-autocomplete li:first a').click
    within('#new_stock_holding') do
      fill_in 'stock_holding_starting_shares', :with => '10'
      fill_in 'stock_holding_starting_price', :with => '$7.50'
      select '2010', :from => 'stock_holding_purchased_at_1i'
      select 'October', :from => 'stock_holding_purchased_at_2i'
      select '11', :from => 'stock_holding_purchased_at_3i'
      click_on('Create')
    end
    @portfolio.reload
    @portfolio.stock_holdings.size.should == 1
  end
  
  scenario 'validates for required information' do
    visit '/dashboard'
    find('.portfolio-content a.add-stock').click
    within('#new_stock_holding') do
      click_on('Create')
    end
    @portfolio.stock_holdings.size.should == 0
  end
  
end