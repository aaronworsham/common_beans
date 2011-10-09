class DowIndex

  def self.investment_delta(options={})
    options[:todays_value] - self.todays_value(number_of_shares(options[:starting_investment], options[:dow_eod]))
  end

  def self.number_of_shares(investment, dow_eod)
    investment / dow_eod.close
  end

  def self.todays_value(shares)
    shares * self.todays_close
  end

  def self.todays_close
    @close ||= todays_eod.close
  end

  def self.todays_eod
    @eod ||= DowIndexEod.last
  end

end