class Portfolio < ActiveRecord::Base

  extend Rankable

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
      array << p.compare_indices
    end
    array
  end
  def self.compare_values_for_user(user)
    array = []
    portfolios = user.portfolios
    portfolios.each do |p|
      array << p.compare_values
    end
    array
  end
  def self.compare_rankings_for_user(user)
    array = []
    portfolios = user.portfolios
    portfolios.each do |p|
      array << p.compare_rankings
    end
    array
  end






  def compare_indices
    {
      :name => self.name,
      :id => self.id,
      :since => self.started_at.strftime('%D'),
      :gain_ratio => self.total_gain_ratio,
      :indices_gain => SecurityIndex.gains_since(self.started_at)
    }
  end

  def compare_values
    {
      :name => self.name,
      :id => self.id,
      :since => self.started_at.strftime('%D'),
      :current_value => self.total_value,
      :starting_value => self.starting_investment,
      :past_values => self.get_total_past_values
    }
  end
  def compare_rankings
    {
      :name => self.name,
      :id => self.id,
      :since => self.started_at.strftime('%D'),
      :past_plan_ranks => self.get_past_plan_rankings,
      :past_strategy_ranks => self.get_past_strategy_rankings
    }
  end


  def cached_holdings
    @holdings ||= self.stock_holdings +
                  self.fund_holdings +
                  self.etf_holdings +
                  self.bond_holdings +
                  self.cd_holdings
  end

  def reload_cached_holdings
    @holdings = self.stock_holdings +
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
    if total_value_gain == 0 or total_investment == 0
      return 0
    else
      (total_value_gain/total_investment*100).round(3)
    end
  end

  def get_total_past_values
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_total_value")
    end
    hash
  end
  def get_total_past_value_gains
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_total_value_gain")
    end
    hash
  end
  def get_total_past_gain_ratios
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_total_gain_ratio")
    end
    hash
  end
  def get_past_plan_rankings
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_plan_rank")
    end
    hash
  end
  def get_past_strategy_rankings
    hash = Hash.new
    Point.names.each do |d|
      hash[d] = self.send("#{d}_strategy_rank")
    end
    hash
  end

  Point.names.each do |pre|
    %w(value value_gain gain_ratio).each do |name|
      define_method("#{pre}_total_#{name}") do
        sum_holding_value("#{pre}_#{name}")
      end
    end
  end

  def started_at
    if cached_holdings.size > 0
      cached_holdings.sort_by(&:purchased_at).first.purchased_at
    else
      self.created_at
    end
  end

  def starting_investment
    if cached_holdings.size > 0
      cached_holdings.sort_by(&:purchased_at).first.starting_investment
    else
      0
    end
  end

  def sum_holding_value(method)
    cached_holdings.reject{|x| x.send(method).nil?}.inject(0){|s, h| s + h.send(method)}
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

  def populate_points
    past_values = self.get_total_past_values
    past_value_gains = self.get_total_past_value_gains
    past_gain_ratios = self.get_total_past_gain_ratios
    Point.names.each do |n|
      self.send("#{n}_value=", past_values[n])
      self.send("#{n}_value_gain=", past_value_gains[n])
      self.send("#{n}_gain_ratio=", past_gain_ratios[n])
    end
    self.points_updated_at = Date.today
    self.save
  end
end
