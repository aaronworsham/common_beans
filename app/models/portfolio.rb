class Portfolio < ActiveRecord::Base
  has_many :holdings, :dependent => :destroy
  has_many :group_portfolios, :dependent => :destroy
  belongs_to :user

  EOD = %w(day week one_month three_month six_month nine_month one_year two_year three_year)
  METHODS = %w( price price_gain_to_today price_gain_delta price_gain_percent_delta
                    value value_gain_to_today value_gain_delta value_gain_percent_delta)

  def cached_holdings
    @holdings ||= self.holdings
  end

  def total_value
    sum_holding_value("todays_value")
  end

  def total_gain
    sum_holding_value("total_gain")
  end


  EOD.each do |eod|
    METHODS.each do |sum|
      method = "#{eod}_#{sum}"
      define_method(method) do
        sum_holding_value(method)
      end
    end
  end

  def sum_holding_value(method)
    cached_holdings.inject(0){|s, h| s + h.send(method)}
  end

  def as_json(options={})
    result = super(options)
    result["trust"] = self.min_trust_level
    result["total_value"] = self.total_value
    result["total_gain"] = self.total_gain
    EOD.each do |x|
      METHODS.each do |sum|
        method = "#{x}_#{sum}"
        result[method] = self.send(method)
      end
    end
    result['holding_ids'] = self.holdings.map{|x| x.id}
    result
  end
end
