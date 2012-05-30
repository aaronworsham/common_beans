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