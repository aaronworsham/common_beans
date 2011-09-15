class MessageEveryone < Message

  def self.head
    jsonify($redis.lrange("message:everyone",0, 20))
  end

  def initialize(options)
    @queue = "everyone"
    super
  end


end
