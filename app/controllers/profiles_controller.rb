class ProfilesController < ApplicationController
  respond_to :html, :json

  def index
    @profiles = current_user.profiles
    respond_with(@profiles)
  end

  def show
    @profile = Profile.find_by_id params[:id]
    respond_with(@profile)
  end

  def create
    @profile = Profile.create(params[:profile].merge(:user => current_user))
    respond_with(@profile)
  end
end
