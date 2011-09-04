class CreateTickers < ActiveRecord::Migration
  def change
    create_table :tickers do |t|
      t.string :symbol
      t.string :name
      t.integer :exchange_id

      t.timestamps
    end
  end
end
