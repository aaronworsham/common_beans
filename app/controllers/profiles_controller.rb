class ProfilesController < ApplicationController
  layout 'profile'
  def show
    @user = User.find_by_screen_name params[:screen_name]
  end

end
