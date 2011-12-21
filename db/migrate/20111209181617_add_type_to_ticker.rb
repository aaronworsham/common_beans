class AddTypeToTicker < ActiveRecord::Migration
  def change
    add_column  :tickers,  :type,  :string
  end
end
