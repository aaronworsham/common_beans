class Portfolio < ActiveRecord::Base
  has_many :holdings, :dependent => :destroy
  belongs_to :user

  def as_json(options={})
    result = super(options)
    result["total_value"] = self.total_value
    result["total_gain"] = self.total_gain
    result["day_delta"] = self.day_delta
    result["week_delta"] = self.week_delta
    result["one_month_delta"] = self.one_month_delta
    result["three_month_delta"] = self.three_month_delta
    result["six_month_delta"] = self.six_month_delta
    result["nine_month_delta"] = self.nine_month_delta
    result["one_year_delta"] = self.one_year_delta
    result["two_year_delta"] = self.two_year_delta
    result["three_year_delta"] = self.three_year_delta
    result
  end

  def cached_holdings
    @holdings ||= self.holdings
  end

  def total_value
    @todays_value ||= cached_holdings.inject(0){|s, h| s + h.todays_value}
  end
  def total_gain
    @todays_gain ||= cached_holdings.inject(0){|s, h| s + h.total_gain}
  end
  def day_delta
    @day_delta ||= cached_holdings.inject(0){|s, h| s + h.day_delta}
  end
  def week_delta
    @week_delta ||= cached_holdings.inject(0){|s, h| s + h.week_delta}
  end
  def one_month_delta
    @one_month_delta ||= cached_holdings.inject(0){|s, h| s + h.one_month_delta}
  end
  def three_month_delta
    @three_month_delta ||= cached_holdings.inject(0){|s, h| s + h.three_month_delta}
  end
  def six_month_delta
    @six_month_delta ||= cached_holdings.inject(0){|s, h| s + h.six_month_delta}
  end
  def nine_month_delta
    @nine_month_delta ||= cached_holdings.inject(0){|s, h| s + h.nine_month_delta}
  end
  def one_year_delta
    @one_year_delta ||= cached_holdings.inject(0){|s, h| s + h.one_year_delta}
  end
  def two_year_delta
    @two_year_delta ||= cached_holdings.inject(0){|s, h| s + h.two_year_delta}
  end
  def three_year_delta
    @three_year_delta ||= cached_holdings.inject(0){|s, h| s + h.three_year_delta}
  end
end
