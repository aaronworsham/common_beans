require 'spec_helper'

describe 'Portfolio Ranking' do
  fixtures :portfolio_plans, :portfolio_strategies
  before(:each) do
    %w(10, 25, 55, 99).each do |vg|
      Factory :portfolio,
              :d5_value_gain => vg,
              :d30_value_gain => vg,
              :d90_value_gain => vg,
              :d180_value_gain => vg,
              :y1_value_gain => vg,
              :y2_value_gain => vg,
              :y3_value_gain => vg,
              :y4_value_gain => vg,
              :y5_value_gain => vg,
              :portfolio_plan_id => 1,
              :portfolio_strategy_id => 1
    end
    @p = Factory :portfolio,
                :d5_value_gain => 70,
                :d30_value_gain => 70,
                :d90_value_gain => 70,
                :d180_value_gain => 70,
                :y1_value_gain => 70,
                :y2_value_gain => 70,
                :y3_value_gain => 70,
                :y4_value_gain => 70,
                :y5_value_gain => 70,
                :portfolio_plan_id => 1,
                :portfolio_strategy_id => 1
    Portfolio.populate_plan_rankings
    Portfolio.populate_strategies_rankings
    @p.reload
  end

  %w(d5 d30 d90 d180 y1 y2 y3 y4 y5).each do |pre|
    it "should rank value growth of 70 as 80% for #{pre} plan" do
      @p.send("#{pre}_plan_rank").should eq(80)
    end
    it "should rank value growth of 70 as 80% for #{pre} strategy" do
      @p.send("#{pre}_strategy_rank").should eq(80)
    end
  end
end