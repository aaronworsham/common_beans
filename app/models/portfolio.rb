class Portfolio < ActiveRecord::Base
  has_many :stock_holdings, :dependent => :destroy
  has_many :fund_holdings, :dependent => :destroy
  has_many :etf_holdings, :dependent => :destroy
  has_many :bond_holdings, :dependent => :destroy
  has_many :cd_holdings, :dependent => :destroy
  has_many :group_portfolios, :dependent => :destroy
  belongs_to  :portfolio_plan
  belongs_to  :portfolio_strategy
  belongs_to  :user

  validates_associated :portfolio_plan
  validates_associated :portfolio_strategy
  validates_presence_of :name
  validates_presence_of :portfolio_plan_id
  validates_presence_of :portfolio_strategy_id
  validates_associated :user

  def self.compare_indices_for_user(user)
    array = []
    portfolios = user.portfolios
    portfolios.each do |p|
      array << {
        :name => p.name,
        :id => p.id,
        :since => p.started_at.strftime('%D'),
        :gain_ratio => p.total_gain_ratio,
        :indices_gain => SecurityIndex.gains_since(p.started_at)
      }
    end
    array
  end

  def cached_holdings
    @holdings ||= self.stock_holdings +
                  self.fund_holdings +
                  self.etf_holdings +
                  self.bond_holdings +
                  self.cd_holdings
  end

  def total_value
    sum_holding_value("todays_value")
  end

  def total_value_gain
    sum_holding_value("total_value_gain")
  end

  def total_investment
    cached_holdings.inject(0){|x,y| x + y.net_investment}
  end

  def total_gain_ratio
    (total_value_gain/total_investment*100).round(3)
  end

  Point.names.each do |pre|
    %w(value value_gain gain_ratio).each do |name|
      define_method("#{pre}_total_#{name}") do
        sum_holding_value("#{pre}_#{name}")
      end
    end
  end

  def started_at
    cached_holdings.sort_by(&:purchased_at).first.purchased_at
  end

  def sum_holding_value(method)
    cached_holdings.inject(0){|s, h| s + h.send(method)}
  end

  def as_json(options={})
    result = super(options)
    result["trust"] = self.trust_level
    result["portfolio-plan"] = self.portfolio_plan.name
    result["portfolio-strategy"] = self.portfolio_strategy.name
    result["total_value"] = self.total_value
    result["total_value_gain"] = self.total_value_gain
    result['holding_ids'] = self.cached_holdings.map{|x| x.id}
    result
  end
end
