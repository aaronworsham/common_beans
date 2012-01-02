class SessionsController < ApplicationController
  def create 
    auth = request.env["omniauth.auth"]  
    #logger.info auth.inspect
    begin
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    rescue => e
      p 'ERROR'
      p e.message
    end
    session[:user_id] = user.id
    session[:auth_provider] = auth["provider"]
    cookies[:preferred_provider] = auth["provider"]
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"
  end
end
