class MessagesController < ApplicationController
  def index
    @messages = MessageReader.queue('everyone').map{|x| JSON.parse(x)}
  end
end
