class AddStockFieldsToStockTickers < ActiveRecord::Migration
  def change
    add_column :stock_tickers, :summary, :text
    add_column :stock_tickers, :sector, :string
    add_column :stock_tickers, :industry, :string
    add_column :stock_tickers, :url, :string
  end
end
