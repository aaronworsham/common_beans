class Nasdaq100Index < SecurityIndex
  def symbol
    '^NDX' #this is an ETF that tracks the Dow, since Yahoo is restricted from API calls for Dow
  end


end
