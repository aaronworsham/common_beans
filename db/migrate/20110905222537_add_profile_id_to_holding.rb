class AddProfileIdToHolding < ActiveRecord::Migration
  def change
    add_column :holdings, :profile_id, :integer
  end
end
