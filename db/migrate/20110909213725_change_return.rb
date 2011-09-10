class ChangeReturn < ActiveRecord::Migration
  def up
    rename_column :sells, :return, :return_on_investment
  end

  def down
    rename_column :sells, :return_on_investment, :return
  end
end
