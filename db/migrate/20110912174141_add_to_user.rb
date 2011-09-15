class AddToUser < ActiveRecord::Migration
  def up
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end

  def down
    remove_column :users, :uid
    remove_column :users, :provider
  end
end
