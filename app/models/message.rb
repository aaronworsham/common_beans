class Message 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  

  def initialize(options)
    @text = options[:text]
    @action = options[:action]
    @user_screen_name = options[:user].screen_name
    @user_image_url = options[:user].image_url
    @date = Time.now
    @id = SecureRandom.uuid
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

  def self.jsonify(data)
    if data.respond_to?('join')
      "[#{data.join(',')}]"
    else
      "[#{data}]"
    end
  end

end
