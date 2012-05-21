class UsTbill30yIndex < SecurityIndex
  def symbol
    '^TYX' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
