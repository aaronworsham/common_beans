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

  def total_gain
    sum_holding_value("total_gain")
  end

  def sum_holding_value(method)
    cached_holdings.inject(0){|s, h| s + h.send(method)}
  end

  def as_json(options={})
    result = super(options)
    result["trust"] = self.trust_level
    result["total_value"] = self.total_value
    result["total_gain"] = self.total_gain
    result['holding_ids'] = self.cached_holdings.map{|x| x.id}
    result
  end
end
