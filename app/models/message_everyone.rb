class MessageEveryone < Message

  def self.head
    jsonify($redis.lrange("message:everyone",0, 20))
  end

  def self.head_count
    $redis.lrange("message:everyone",0, 20).size
  end

  def initialize(options)
    @queue = "everyone"
    super
  end


end
