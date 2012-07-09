class SessionsController < ApplicationController
  def create 
    auth = request.env["omniauth.auth"]  
    user = (User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth))
    if user
      if user.last_login_version.present?
        cookies[:cb_notify] = "Your last login was version #{user.last_login_state} - #{user.last_login_version} <a href='/stories'> Here are the fixes since you last logged in</a>"
      end
      user.update_attributes(
        :last_login_version => Settings.version.number,
        :last_login_state => Settings.version.state,
        :last_logged_in_at => Time.now
      )
      
      
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
