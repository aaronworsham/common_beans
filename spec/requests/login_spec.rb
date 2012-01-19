require 'spec_helper'

feature "login" do
  
  scenario 'via twitter' do
    # user = Factory(:twitter_user)
    # visit '/auth/twitter'
    # current_path.should eql('/dashboard')
    # page.should have_content("Signed in!")
  end
  
  scenario 'via facebook' do
    # user = Factory(:facebook_user)
    # visit '/auth/facebook'
    # current_path.should eql('/dashboard')
    # page.should have_content("Signed in!")
  end
  
  scenario 'via google' do
    # user = Factory(:google_user)
    # visit '/auth/google'
    # current_path.should eql('/dashboard')
    # page.should have_content("Signed in!")
  end
  
end