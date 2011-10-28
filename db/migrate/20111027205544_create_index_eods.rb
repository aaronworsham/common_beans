class CreateIndexEods < ActiveRecord::Migration
  def change
    create_table :index_eods do |t|
      t.integer  "index_id"
      t.decimal  "close"
      t.decimal  "high"
      t.decimal  "low"
      t.decimal  "open"
      t.date     "closed_on"
      t.timestamps
    end
  end
end
