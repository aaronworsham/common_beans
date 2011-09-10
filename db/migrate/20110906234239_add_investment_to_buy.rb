class AddInvestmentToBuy < ActiveRecord::Migration
  def change
    add_column :buys, :investment, :decimal, :precision => 15, :scale => 2
  end
end
