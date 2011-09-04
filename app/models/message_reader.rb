class MessageReader

  def self.queue(queue)
    @queue = queue
    $redis.lrange(redis_queue_key, 0, 20)
  end

  def self.redis_queue_key
    "message:#{@queue}"
  end

end
