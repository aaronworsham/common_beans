class AddDowEodToHolding < ActiveRecord::Migration
  def change
    add_column    :holdings,      :dow_index_eod_id,    :integer

  end
end
