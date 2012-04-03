class AddNameToMultiHolding < ActiveRecord::Migration
  def change
    add_column  :multi_holdings, :name, :string
  end
end
