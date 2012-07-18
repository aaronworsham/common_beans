class DashboardController < ApplicationController
  before_filter :login_required
  before_filter :setup_messages
  layout 'dashboard'
  
  def show
    @models = current_user.backbone_models
    @compare_indices = Portfolio.compare_indices_for_user(current_user)
    @compare_values = Portfolio.compare_values_for_user(current_user)
    @invites_from= current_user.invites_from
    @invites_from_group = @invites_from.in_groups_of(5)
    @invites_to= current_user.invites_to
    @invites_to_group = @invites_to.in_groups_of(5)
    @friends = current_user.friends
    @friends_group = @friends.in_groups_of(5)
    @friend_models = current_user.friend_backbone_models
    @actions = Action.all.reject{|x| x[:user] == current_user}
    if @invites_from.present?
      cookies[:cb_notify] = "You have #{@invites_from.count} Friend Invites"
    end
  end
end
