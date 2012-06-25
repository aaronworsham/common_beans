class AddPointInTimeToMulti < ActiveRecord::Migration
  def change
    add_column :multi_statement_allocations, :allocated_on, :date
    add_column :multi_statement_allocations, :price_at_allocation, :decimal, :precision => 15, :scale => 2
    add_column :multi_holding_allocations, :allocated_on, :date
    add_column :multi_holding_allocations, :price_at_allocation, :decimal, :precision => 15, :scale => 2
  end
end
