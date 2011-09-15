class UpdatesToUser < ActiveRecord::Migration
  def up
    add_column :users, :image_url, :string
    add_column :users, :location, :string
    add_column :users, :description, :text
    add_column :users, :urls, :text
    rename_column :users, :screename, :screen_name
  end

  def down
    remove_column :users, :image_url
    remove_column :users, :location
    remove_column :users, :description
    remove_column :users, :urls
    rename_column :users, :screen_name, :screename
  end
end
