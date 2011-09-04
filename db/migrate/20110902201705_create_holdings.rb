class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :ticker_id
      t.integer :shares
      t.decimal :purchase_price, :precision => 15, :scale => 2
      t.decimal :investment, :precision => 15, :scale => 2

      t.timestamps
    end
  end
end
