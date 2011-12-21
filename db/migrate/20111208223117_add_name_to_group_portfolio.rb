class AddNameToGroupPortfolio < ActiveRecord::Migration
  def change
    add_column :group_portfolios, :name, :string
  end
end
