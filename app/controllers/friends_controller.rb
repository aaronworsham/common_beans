class FriendsController < ApplicationController
  respond_to :html, :json
  before_filter :login_required

  def update
    @friend = User.find_by_id params[:id]
    current_user.follow!(@friend)
    respond_with(@friend)
  end
end
