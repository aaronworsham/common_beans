class Portfolio < ActiveRecord::Base
  has_many :holdings, :dependent => :destroy
  belongs_to :user

  def as_json(options={})
    result = super(options)
    result["total_value"] = self.total_value
    result["total_gain"] = self.total_gain
    result["day_delta_value"] = self.day_delta_value
    result["week_delta_value"] = self.week_delta_value
    result["one_month_delta_value"] = self.one_month_delta_value
    result["three_month_delta_value"] = self.three_month_delta_value
    result["six_month_delta_value"] = self.six_month_delta_value
    result["nine_month_delta_value"] = self.nine_month_delta_value
    result["one_year_delta_value"] = self.one_year_delta_value
    result["two_year_delta_value"] = self.two_year_delta_value
    result["three_year_delta_value"] = self.three_year_delta_value
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
  def day_delta_value
    @day_delta_value ||= cached_holdings.inject(0){|s, h| s + h.day_delta_value}
  end
  def week_delta_value
    @week_delta_value ||= cached_holdings.inject(0){|s, h| s + h.week_delta_value}
  end
  def one_month_delta_value
    @one_month_delta_value ||= cached_holdings.inject(0){|s, h| s + h.one_month_delta_value}
  end
  def three_month_delta_value
    @three_month_delta_value ||= cached_holdings.inject(0){|s, h| s + h.three_month_delta_value}
  end
  def six_month_delta_value
    @six_month_delta_value ||= cached_holdings.inject(0){|s, h| s + h.six_month_delta_value}
  end
  def nine_month_delta_value
    @nine_month_delta_value ||= cached_holdings.inject(0){|s, h| s + h.nine_month_delta_value}
  end
  def one_year_delta_value
    @one_year_delta_value ||= cached_holdings.inject(0){|s, h| s + h.one_year_delta_value}
  end
  def two_year_delta_value
    @two_year_delta_value ||= cached_holdings.inject(0){|s, h| s + h.two_year_delta_value}
  end
  def three_year_delta_value
    @three_year_delta_value ||= cached_holdings.inject(0){|s, h| s + h.three_year_delta_value}
  end
end
