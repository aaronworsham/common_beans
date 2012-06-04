class SessionsController < ApplicationController
  def create 
    auth = request.env["omniauth.auth"]  
    user = (User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth))
    session[:user_id] = user.id
    session[:auth_provider] = auth["provider"]
    cookies[:preferred_provider] = auth["provider"]
    if user.advisor?
      redirect_to financial_advisor_root_path, :notice => "Thanks for signing in, advisor"
    else
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Signed out!"
  end
end
