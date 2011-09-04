class Messagefriend < Message

  def initialize(options)
    @queue = "friend:#{options[:friend]}"
    super
  end
end
