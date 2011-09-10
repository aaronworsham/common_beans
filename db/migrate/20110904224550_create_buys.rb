class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.integer :ticker_id
      t.integer :holding_id
      t.integer :user_id
      t.integer :shares
      t.decimal :price, :precision => 15, :scale => 2
      t.timestamps
    end
  end
end
