class UsersController < ApplicationController
  autocomplete :user, :screen_name, :full => true
  respond_to :html, :json
  def show
    @users = User.where(:screen_name => params[:term]).all
    respond_with do |x|
      x.json {render :json => @users.map{|x| {:id => x.id, :label => "#{x.screen_name} from #{x.provider || 'parts unknown'}", :value => x.screen_name}}}
      x.html {}
    end
  end
  def public_from_id
    @user = User.find_by_id params[:id]
    render :template => '/users/public'
  end
  def twitter
    @user = User.find_by_screen_name_and_provider params[:screen_name], 'twitter'
    render :template => '/users/public'
  end
  def facebook
    @user = User.find_by_screen_name params[:screen_name], 'facebook'
    render :template => '/users/public'
  end
end
