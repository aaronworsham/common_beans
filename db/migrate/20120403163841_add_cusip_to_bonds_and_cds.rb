class AddCusipToBondsAndCds < ActiveRecord::Migration
  def change
    add_column :bond_holdings, :cusip, :string
    add_column :cd_holdings, :cusip, :string
  end
end
