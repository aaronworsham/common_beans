class AlterHoldingName < ActiveRecord::Migration
  def up
    rename_table :holdings, :stock_holdings
  end

  def down
    rename_table :stock_holdings, :holdings
  end
end
