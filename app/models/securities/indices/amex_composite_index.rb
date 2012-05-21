class AmexCompositeIndex < SecurityIndex
  def symbol
    '^XAX' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
