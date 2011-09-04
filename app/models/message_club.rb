class MessageClub < Message

  def initialize(options)
    @queue = "club:#{options[:club]}"
    super
  end
end
