class IdentitiesController < ApplicationController
  def new
    @identity = env['omniauth.identity']
    Rails.logger.info @identity.inspect
  end
  def index
   # @identity = env['omniauth.identity']
  end
  
  def failure
    redirect_to identities_path, :flash  => { :error => "Wrong credentials, please try again"} 
  end
end
