class ReworkHolding < ActiveRecord::Migration
  def up
    add_column :holdings, :starting_shares, :integer
    add_column :holdings, :starting_price, :decimal,  :precision => 6, :scale => 2
    add_column :holdings, :starting_investment, :decimal,   :precision => 15, :scale => 2
    add_column :holdings, :date_of_purchase, :datetime
    add_column :holdings, :net_shares, :integer
    add_column :holdings, :net_investment, :decimal, :precision => 15, :scale => 2
    add_column :holdings, :net_return, :decimal,  :precision => 15, :scale => 2
  end

  def down
    remove_column :holdings, :starting_shares
    remove_column :holdings, :starting_price
    remove_column :holdings, :starting_investment
    remove_column :holdigns, :date_of_purchase
    remove_column :holdings, :net_shares
    remove_column :holdings, :net_investment
    remove_column :holdigns, :net_return
  end
end
