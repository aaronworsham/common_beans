class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  
  def show
    @models = current_user.backbone_models
    @compare_indices = Portfolio.compare_indices_for_user(current_user)
  end
end
