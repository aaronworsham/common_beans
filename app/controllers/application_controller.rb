class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

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
