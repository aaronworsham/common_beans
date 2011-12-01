class Message 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :text, :action, :user_id, :user_screen_name, :user_image_url, :date, :id, :uuid

  def initialize(options)
    raise MessageError::MissingParams unless (options.present? and options[:text].present? and options[:action].present? and options[:user].present?)
    self.text = options[:text]
    self.action = options[:action]
    self.user_id = options[:user].id
    self.user_screen_name = options[:user].screen_name
    self.user_image_url = options[:user].image_url
    self.date = Time.now
    self.uuid = SecureRandom.uuid
    self.id = self.reader.count + 1
  end


  def save
    $redis.lpush(redis_queue_key, self.to_json)
  end


  def redis_queue_key
    "message:#{self.queue}"
  end


  def self.reader
    MessageReader.new(self.queue)
  end



end
