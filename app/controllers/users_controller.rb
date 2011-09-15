class UsersController < ApplicationController
  def show
    @user = User.find_by_screen_name params[:screen_name]
  end  
  def public
    @user = User.find_by_screen_name params[:screen_name]
  end
end
