class DashboardController < ApplicationController
  before_filter :login_required
  #before_filter :setup_messages
  layout 'dashboard'
  
  def show
    @models = current_user.all_as_json
  end
end
