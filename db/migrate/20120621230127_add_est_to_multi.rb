class AddEstToMulti < ActiveRecord::Migration
  def change
    add_column :multi_statement_allocations, :est_units, :float
    add_column :multi_holding_allocations, :est_units, :float
    add_column :multi_statement_allocations, :est_value_at_allocation, :float
    add_column :multi_holding_allocations, :est_value_at_allocation, :float
  end
end
