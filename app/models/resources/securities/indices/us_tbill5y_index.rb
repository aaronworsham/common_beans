class UsTbill5yIndex < SecurityIndex
  def symbol
    '^FVX' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
