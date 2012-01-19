require 'spec_helper'

feature "add stock to portfolio" do
  before(:each) do
    visit '/auth/twitter'
    @portfolio = Factory :portfolio, :user => User.first
  end
  
  scenario 'accessible from portfolio' do
    visit '/dashboard'
    within('#portfolios-hotlist') do
      page.should have_content(@portfolio.name)
    end
  end
  
  scenario 'add form has correct fields' do
  end
  
  scenario 'create new stock' do
  end
  
  scenario 'validates for required information' do
  end
  
end