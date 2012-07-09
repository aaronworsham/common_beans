class AddVersionToUserLogin < ActiveRecord::Migration
  def change
    add_column :users, :last_login_version, :string
    add_column :users, :last_login_state, :string
    add_column :users, :last_logged_in_at, :datetime
  end
end
