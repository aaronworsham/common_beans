class Sell < Holding

  after_create :notify_everyone

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :action   => 'sold',
      :user     => user.screename
    ).save
  end

  def standard_message
    "#{shares} shares of #{ticker.symbol}"
  end
end
