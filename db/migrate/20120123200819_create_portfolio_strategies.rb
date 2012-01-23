class CreatePortfolioStrategies < ActiveRecord::Migration
  def change
    create_table :portfolio_strategies do |t|
      t.string      :name
      t.timestamps
    end
  end
end
