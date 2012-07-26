class Russell3000Index < SecurityIndex
  def symbol
    '^RUA' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
