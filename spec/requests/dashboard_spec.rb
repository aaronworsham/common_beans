require 'spec_helper'

describe "Dashboard" do

   before(:each) do
     Factory  :user,
              :name => 'test',
              :screen_name => 'test',
              :provider => 'twitter',
              :uid => '12345'

     visit '/auth/twitter'
   end

  it "logs in" do
    visit '/dashboard'
    page.should have_content("Hi test")
  end
  describe "New Portfolio" do
    before(:each) do
      visit '/dashboard'
    end
    it 'should show new portfolio form when add protfolio is clicked' do
      find('#new_portfolio').visible?.should be_false
      find('#portfolios-hotlist .add_item').click
      find('#new_portfolio').visible?.should be_true
    end
    it 'should have one field and one dropdown' do
      find('#portfolios-hotlist .add_item').click
      page.should have_selector('#new_portfolio input#portfolio_name')
      page.should have_selector('#new_portfolio select#portfolio_trust_level')
    end
  end





end