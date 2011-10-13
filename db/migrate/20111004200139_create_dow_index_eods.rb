class CreateDowIndexEods < ActiveRecord::Migration
  def change
    create_table :dow_index_eods do |t|
      t.decimal     :close,         :precision => 8, :scale => 2
      t.float       :net_change
      t.date        :closed_on
      t.timestamps
    end
  end
end
