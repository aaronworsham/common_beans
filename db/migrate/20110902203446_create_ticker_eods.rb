class CreateTickerEods < ActiveRecord::Migration
  def change
    create_table :ticker_eods do |t|
      t.integer :ticker_id
      t.decimal :close
      t.decimal :high
      t.decimal :low
      t.decimal :open

      t.timestamps
    end
  end
end
