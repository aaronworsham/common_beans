class NyseCompositeIndex < SecurityIndex
  def symbol
    '^NYE' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
