class FriendsController < ApplicationController

  respond_to :html, :json
  def destroy
    user = User.find_by_id params[:id]
    current_user.distrust!(user) if user
    respond_with user
  end

  def accept
    user = User.find_by_id params[:id]
    current_user.trust!(user, 5)
    respond_with user
  end

end
