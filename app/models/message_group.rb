class MessageGroup< Message

  def initialize(options)
    @queue = "group:#{options[:group]}"
    super
  end
end
