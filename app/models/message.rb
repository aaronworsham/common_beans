class Message
  

  def initialize(options)
    @text = options[:text]
    @action = options[:action]
    @user = options[:user]
    @date = Time.now
  end


  def save
    $redis.lpush(redis_type_key, self.to_json)
    $redis.lpush(redis_queue_key, self.to_json)
  end

  def redis_type_key
    "message:#{@queue}:#{@type}"
  end

  def redis_queue_key
    "message:#{@queue}"
  end

end
