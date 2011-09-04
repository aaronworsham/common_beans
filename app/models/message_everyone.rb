class MessageEveryone < Message

  def initialize(options)
    @queue = "everyone"
    super
  end
end
