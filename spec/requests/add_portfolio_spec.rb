require 'spec_helper'

feature "add portfolio" do
  before(:each) do
    visit '/auth/twitter'
    
  end
  
  scenario 'add form has correct fields'do
    visit '/dashboard'  
    find('#portfolios-hotlist .add_item').click
    page.should have_selector('#new_portfolio input#portfolio_name')
    page.should have_selector('#new_portfolio select#portfolio_trust_level')
  end
  
  scenario 'create new portfolio' do
    visit '/dashboard'
    within('#portfolios-hotlist') do
      page.should_not have_content('test portfolio')
    end
    find('#portfolios-hotlist .add_item').click
    within("#new_portfolio") do
      fill_in 'Name', :with => 'test portfolio'
      select('3 - Private: \'Friends\' can see safe version plus \'Family and Advisors\'', :from => 'Minimum TRUST level')
    end
    click_on('Create')
    within('#portfolios-hotlist') do
      page.should have_content('test portfolio')
    end
    p = Portfolio.last
    p.name.should == 'test portfolio'
    p.trust_level.should == 3
    p.user_id.should == 1

    Portfolio.count.should eql(1)
  end
  
  scenario 'validates for required information' do
    visit '/dashboard'  
    find('#portfolios-hotlist .add_item').click
    click_on('Create')
    
    Portfolio.count.should eql(0)
  end
  
end