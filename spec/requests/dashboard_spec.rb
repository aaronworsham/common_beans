require 'spec_helper'

describe "Dashboard" do

   before(:each) do
      @mock_controller = mock("ApplicationController")
      @mock_controller.stub(:current_user).and_return(User.first)
   end

  it "logs in" do
    visit '/'
    page.should have_content("Hey there user!")
  end

end