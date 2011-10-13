class AddDowEodToEvents < ActiveRecord::Migration
  def change
    add_column      :events,    :dow_index_eod_id,    :integer
  end
end
