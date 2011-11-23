class MessageReader

  attr_accessor :queue

  def initialize(queue)
    self.queue = queue
  end

  def read(len = 20)
    $redis.lrange(redis_queue_key, 0, len)
  end

  def last_entry
    $redis.lrange(redis_queue_key, 0, 0).first
  end

  def redis_queue_key
    "message:#{self.queue}"
  end

  def head
    jsonify($redis.lrange(redis_queue_key,0, 20))
  end

  def count
    $redis.llen(redis_queue_key)
  end

  def jsonify(data)
    if data.respond_to?('join')
      "[#{data.join(',')}]"
    else
      "[#{data}]"
    end
  end
end
