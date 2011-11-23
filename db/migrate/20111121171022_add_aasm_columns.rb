class AddAasmColumns < ActiveRecord::Migration
  def up
    add_column  :group_portfolios,  :current_state,  :string
    add_column  :events,          :current_state,  :string
    add_column  :holdings,        :current_state,  :string
    add_column  :portfolios,      :current_state,  :string
    add_column  :users,           :current_state,  :string
  end

  def down
    remove_column  :group_portfolios,  :current_state
    remove_column  :events,          :current_state
    remove_column  :holdings,        :current_state
    remove_column  :portfolios,      :current_state
    remove_column  :users,           :current_state
  end
end
