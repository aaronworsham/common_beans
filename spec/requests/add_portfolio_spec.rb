require 'spec_helper'

feature "add portfolio" do
  fixtures :portfolio_plans, :portfolio_strategies
  before(:each) do
    visit '/auth/twitter'
    
  end
  
  scenario 'add form has correct fields'do
    visit '/dashboard'  
    find('#nav .add_portfolio_group_action').click
    page.should have_selector('#new_portfolio input#portfolio_name')
    page.should have_selector('#new_portfolio select#portfolio_portfolio_plan')
    page.should have_selector('#new_portfolio select#portfolio_portfolio_strategy')
  end
  
  scenario 'create new portfolio' do
    visit '/dashboard'
    within('#nav') do
      page.should_not have_content('test portfolio')
    end
    find('#nav .add_portfolio_group_action').click
    within("#new_portfolio") do
      fill_in 'Name', :with => 'test portfolio'
      select('growth', :from => 'portfolio_portfolio_plan')
      select('Large Cap Growth', :from => 'portfolio_portfolio_strategy')
    end
    click_on('Create')
    within('#nav') do
      page.should have_content('test portfolio')
    end
    p = Portfolio.last
    p.name.should == 'test portfolio'
    p.portfolio_plan.name.should == 'growth'
    p.portfolio_strategy.name.should == 'Large Cap Growth'
    p.user_id.should == 1

    Portfolio.count.should eql(1)
  end
  
  scenario 'validates for required information' do
    Portfolio.count.should eql(0)

    visit '/dashboard'  
    find('#nav .add_portfolio_group_action').click
    click_on('Create')
    
    Portfolio.count.should eql(0)
  end
  
end