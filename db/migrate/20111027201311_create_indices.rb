class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.string  :symbol
      t.string  :yahoo_symbol
      t.string  :name
      t.integer :exchange_id
      t.timestamps
    end
  end
end
