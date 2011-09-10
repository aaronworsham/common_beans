class AddReturnToSell < ActiveRecord::Migration
  def change
    add_column :sells, :return, :decimal, :precision => 15, :scale => 2
  end
end
