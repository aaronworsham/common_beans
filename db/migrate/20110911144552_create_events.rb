class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :ticker_id
      t.integer :shares
      t.integer :holding_id
      t.string :type
      t.integer :user_id
      t.datetime :date_of_event
      t.decimal  "return_on_investment"
      t.decimal  "investment",    :precision => 15, :scale => 2
      t.decimal :price, :precision => 15, :scale => 2
      t.timestamps
      t.timestamps
    end
  end
end
