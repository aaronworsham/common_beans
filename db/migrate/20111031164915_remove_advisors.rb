class RemoveAdvisors < ActiveRecord::Migration
  def change
    drop_table :advisors
  end
end
