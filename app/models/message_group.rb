class MessageGroup< Message

  attr_accessor :group_id


  def initialize(options)
    raise MessageError::MissingParams unless (options.present? and options[:group].present?)
    self.group_id = options[:group].id
    super
  end

  def queue
    self.class.queue(self.group_id)
  end

  def self.queue(id)
    "group:#{id}"
  end

  def reader
    MessageReader.new(self.queue)
  end

  def self.reader(id)
    MessageReader.new(self.queue(id))
  end

end
