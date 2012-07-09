class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :needs_basic_auth

  def needs_basic_auth
    authenticate_or_request_with_http_basic do |u,p|
      u == "prealpha" && p == "letme1ncb"
    end
  end

  def needs_golden_ticket
    unless has_golden_ticket
      cookies[:cb_notify] = 'bob'
      redirect_to root_path 
    end
  end

  def has_golden_ticket
    cookies[:cb_golden_ticket] 
  end

  def setup_messages
    if current_user
      @friend_messages = current_user.friend_messages
      @group_messages = current_user.group_messages
      @everyone_messages = MessageEveryone.reader.read
    else
      @friend_messages = []
      @group_messages = []
      @everyone_messages = MessageEveryone.reader.read
    end
  end

  def login_required
    unless current_user 
      redirect_to root_path
    end
  end

  def current_user  
    @current_user ||= if Settings.offline
      User.find_by_screen_name('aaronworsham')
    elsif session[:user_id]
      User.find_by_id(session[:user_id])
    else
      nil
    end
  end

  def log_errors(obj)
    logger.error "ERROR: #{obj.errors.to_hash}"
  end
end
