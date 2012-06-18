class UsersController < ApplicationController
  def show
    @user = User.find_by_screen_name params[:screen_name]
  end  
  def twitter
    @user = User.find_by_screen_name_and_provider params[:screen_name], 'twitter'
    render :template => '/users/public'
  end
  def facebook
    @user = User.find_by_screen_name params[:screen_name], 'facebook'
  end
end
