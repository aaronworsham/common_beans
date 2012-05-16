class AddUserIdToMultiStatement < ActiveRecord::Migration
  def change
    add_column :multi_statements,  :user_id, :integer
  end
end
