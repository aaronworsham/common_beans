class TrustController < ApplicationController

  before_filter :login_required

  layout 'profile'

  respond_to :html, :json

  def show
    @trusting = current_user.trusting.map{|x|
      {
        :id => x.id,
        :level => current_user.get_clearance(x),
        :name => x.screen_name,
        :image_url => x.image_url
      }
    }

    @trusted_by = current_user.trusted_by.map{|x|
      {
        :id => x.id,
        :name => x.screen_name,
        :image_url => x.image_url
      }
    }
  end

  def create
    trusting_user = User.find_by_id params[:trust][:user_id]
    level = params[:trust][:level].to_i
    logger.info "TRUST: requesting user #{current_user.screen_name} trust #{trusting_user.screen_name} at level #{level} "
    current_user.trust!(trusting_user, level )
    respond_with do |x|
      x.json {render :json => {:success => true}}
    end
  end
end