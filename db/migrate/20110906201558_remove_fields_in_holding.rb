class RemoveFieldsInHolding < ActiveRecord::Migration
  def up
    remove_column :holdings, :shares
    remove_column :holdings, :purchase_price
    remove_column :holdings, :investment
  end

  def down
    add_column :holdings, :shares, :integer
    add_column :holdings, :purchase_price, :decimal, :precision => 15, :scale => 2
    add_column :holdings, :investment, :decimal, :precision => 15, :scale => 2
  end
end
