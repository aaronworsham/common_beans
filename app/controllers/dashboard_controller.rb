class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  
  def show
    @models = current_user.backbone_models
    @compare_indices = Portfolio.compare_indices_for_user(current_user)
    @compare_values = Portfolio.compare_values_for_user(current_user)
    @invites_from = current_user.invites_from
    @invites_to = current_user.invites_to
    @friends = current_user.friends
  end
end
