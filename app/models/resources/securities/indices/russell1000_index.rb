class Russell1000Index < SecurityIndex
  def symbol
    '^RUI' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
