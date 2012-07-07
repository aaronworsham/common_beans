class UsersController < ApplicationController
  autocomplete :user, :screen_name, :full => true
  respond_to :html, :json
  def show
    @users = User.where("screen_name like ?", "%#{params[:term]}%").all
    respond_with do |x|
      x.json {render :json => @users.map{|x| {:id => x.id, :label => "#{x.screen_name} from #{x.provider || 'parts unknown'}", :value => x.screen_name}}}
      x.html {}
    end
  end
end
