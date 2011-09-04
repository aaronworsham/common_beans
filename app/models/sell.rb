class Sell < Holding

  after_create :notify_everyone

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :type     => 'sell'
    ).save
  end

  def standard_message
    "Has bought #{shares} shares of #{ticker.symbol}"
  end
end
