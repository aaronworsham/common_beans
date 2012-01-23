class AddFieldsToPortfolio < ActiveRecord::Migration
  def change
    add_column  :portfolios,   :plan,           :string
    add_column  :portfolios,   :strategy,       :string
    %w(d7 d30 d180 d365 y2 y3 y4 y5).each do |x|
      add_column  :portfolios,   "#{x}_value".to_sym,       :float
      add_column  :portfolios,   "#{x}_gain".to_sym,       :float
      add_column  :portfolios,   "#{x}_plan_rank".to_sym,       :float
      add_column  :portfolios,   "#{x}_strategy_rank".to_sym,       :float
    end
  end
end
