class AdvisorsController < ApplicationController
  def new
    @identity = env['omniauth.identity']
  end
end
