class Buy < Holding

  after_create :notify_everyone

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :action     => 'bought',
      :user     => self.user.screename
    ).save
  end

  def standard_message
    " #{shares} shares of #{ticker.symbol}"
  end
end
