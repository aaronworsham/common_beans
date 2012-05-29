module Rankable
  def populate_plan_rankings
    Point.names.each do |pre|
      PortfolioPlan.all.each do |plan|
        sorted_array = self.sort_findings(find_plans(plan.id),pre)
        sorted_array.each do |port|
          port.send("#{pre}_plan_rank=", calculate_rank(sorted_array, port))
          port.save
        end
      end
    end
    return true
  end

  def populate_strategies_rankings
    Point.names.each do |pre|
      PortfolioStrategy.all.each do |strategy|
        sorted_array = self.sort_findings(find_strategies(strategy.id),pre)
        sorted_array.each do |port|
          port.send("#{pre}_strategy_rank=", calculate_rank(sorted_array, port))
          port.save
        end
      end
    end
    return true
  end

  def populate_plan_and_strategies_rankings
    Point.names.each do |pre|
      PortfolioPlan.all.each do |plan|
        PortfolioStrategy.all.each do |strategy|
          sorted_array = self.sort_findings(find_plans_and_strategies(plan.id, strategy.id),pre)
          sorted_array.each do |port|
            port.send("#{pre}_plan_and_strategies_rank=", calculate_rank(sorted_array, port))
            port.save
          end
        end
      end
    end
    return true
  end

  def find_plans(id)
    Portfolio.where(:portfolio_plan_id => id)
  end

  def find_strategies(id)
    Portfolio.where(:portfolio_strategy_id => id)
  end

  def find_plans_and_strategies(pid, sid)
    Portfolio.where(
      :portfolio_stragegy_id => pid,
      :portfolio_plan_id => sid)
  end

  def sort_findings(array, pre)
    if array.empty?
      []
    else
      array.all.reject{|x| x.send("#{pre}_value_gain").nil?}.sort_by(&"#{pre}_value_gain".to_sym)
    end
  end

  def calculate_rank(array, port)
    if array.empty?
      0
    else
      ((array.index(port) + 1).to_f/array.size.to_f)*100
    end
  end
end