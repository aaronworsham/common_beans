require 'spec_helper'

feature "add etf to portfolio" do
  fixtures :etf_tickers, :etf_ticker_eods
  before(:each) do
    visit '/auth/twitter'
    EtfHolding.any_instance.stub(:todays_price).and_return(100)
    EtfHolding.any_instance.stub(:todays_value).and_return(1000)
    @portfolio = Factory :portfolio, :user => User.first, :name => 'Test'
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should have_content(@portfolio.name)
    end
    within('.portfolio-content') do
      page.should have_css('a.add-holding[data-security-name=etf]')
    end
  end

  scenario 'create new etf' do
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
    @portfolio.etf_holdings.size.should == 1
    within('#portfolio-content-1 .etf-content') do
      page.should have_content('USO')
      page.should have_content('10')
      page.should have_content('75.0')
    end
  end

  scenario 'validates for required information' do
    visit '/dashboard'
    find('.portfolio-content a.add-holding[data-security-name=etf]').click
    within('#new_etf_holding') do
      click_on('Create')
    end
    @portfolio.etf_holdings.size.should == 0
  end

end