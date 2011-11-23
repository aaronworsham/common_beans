class MessageEveryone < Message


  def initialize(options)
    super
  end

  def queue
    self.class.queue
  end

  def self.queue
    "everyone"
  end

  def reader
    MessageReader.new(self.queue)
  end

  def self.reader
    MessageReader.new(self.queue)
  end

end
