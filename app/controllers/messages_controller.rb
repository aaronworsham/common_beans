class MessagesController < ApplicationController

  before_filter :login_required
  respond_to :json

  def index
    @everyone_messages = MessageEveryone.reader.read.map{|x| JSON.parse(x)}
    @friend_messages = current_user.friend_messages.map{|x| JSON.parse(x)}
    @group_messages = current_user.group_messages.map{|x| JSON.parse(x)}

    respond_with(
      {
        :everyone => @everyone_messages,
        :friend => @friend_messages,
        :group => @group_messages
      }
    )
  end
end
