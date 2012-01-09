require 'spec_helper'

describe "Dashboard" do
   fixtures :users
   before(:each) do
     visit '/auth/twitter'
   end


  it "logs in" do
    visit '/dashboard'
    page.should have_content("Hi test")
  end

  describe "New Portfolio" do

    it 'should not have any portfolios' do
      Portfolio.count.should == 0
    end

    it 'should show new portfolio form when add portfolio is clicked' do
      visit '/dashboard'
      find('#new_portfolio').visible?.should be_false
      find('#portfolios-hotlist .add_item').click
      find('#new_portfolio').visible?.should be_true
    end
    it 'should have one field and one dropdown' do
      visit '/dashboard'
      find('#portfolios-hotlist .add_item').click
      page.should have_selector('#new_portfolio input#portfolio_name')
      page.should have_selector('#new_portfolio select#portfolio_trust_level')
    end
    it 'can create a new portfolio' do
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
      p.delete
    end
    context :has_portfolio do
      before(:each) do
        @portfolio = Factory  :portfolio,
                              :user => User.first,
                              :name => 'test portfolio',
                              :trust_level => 3
      end
      it 'should show the portfolio listed' do
        within('#portfolios-hotlist') do
          page.should have_content('test portfolio')
        end
      end
    end
  end
end