class MessageFriend < Message

  attr_accessor :friend_id


  def initialize(options)
    raise MessageError::MissingParams unless (options.present? and options[:friend].present?)
    raise MessageError::UserNotTrusted unless options[:user].mutual_trust?(options[:friend])
    self.friend_id = options[:friend].id
    super
  end

  def queue
    self.class.queue(self.friend_id)
  end

  def self.queue(id)
    "friend:#{id}"
  end

  def reader
    MessageReader.new(self.queue)
  end

  def self.reader(id)
    MessageReader.new(self.queue(id))
  end

end
