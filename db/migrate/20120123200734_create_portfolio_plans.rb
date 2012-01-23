class CreatePortfolioPlans < ActiveRecord::Migration
  def change
    create_table :portfolio_plans do |t|
      t.string      :name
      t.timestamps
    end
  end
end
