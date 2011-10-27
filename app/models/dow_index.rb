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
    current_eod.close
  end

  def self.yesterdays_close
    close_for_date(1.day.ago.to_date)
  end

  def self.last_weeks_close
    close_for_date(1.week.ago.to_date)
  end

  def self.one_month_close
    close_for_date(1.month.ago.to_date)
  end

  def self.three_month_close
    close_for_date(3.month.ago.to_date)
  end

  def self.six_month_close
    close_for_date(6.month.ago.to_date)
  end

  def self.nine_month_close
    close_for_date(9.month.ago.to_date)
  end

  def self.one_year_close
    close_for_date(1.year.ago.to_date)
  end

  def self.two_year_close
    close_for_date(2.year.ago.to_date)
  end

  def self.three_year_close
    close_for_date(3.year.ago.to_date)
  end

  def self.close_for_date(date)
    past_eod(date).close
  end

  def self.current_eod
    DowIndexEod.last
  end

  def self.past_eod(date)
    return "param is not a Date object" unless date.is_a?(Date)
    eod = DowIndexEod.where("closed_on = ?", date).first
    if eod.nil?
      past_eod(date - 1)
    else
      eod
    end
  end

  def self.range_of_deltas
    {
      :todays_delta => 0.0,
      :yesterdays_delta => percent_delta(todays_close,yesterdays_close),
      :last_weeks_delta => percent_delta(yesterdays_close,last_weeks_close),
      :one_month_delta => percent_delta(last_weeks_close, one_month_close),
      :three_month_delta => percent_delta(one_month_close,three_month_close),
      :six_month_delta => percent_delta(three_month_close, six_month_close),
      :nine_month_delta => percent_delta(six_month_close, nine_month_close),
      :one_year_delta => percent_delta(nine_month_close, one_year_close),
      :two_year_delta => percent_delta(one_year_close, two_year_close),
      :three_year_delta => percent_delta(two_year_close, three_year_close)
    }
  end

  def self.percent_delta(new, old)
    ((new - old)/old)*100
  end
end