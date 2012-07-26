class Russell2000Index < SecurityIndex
  def symbol
    '^RUT' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
