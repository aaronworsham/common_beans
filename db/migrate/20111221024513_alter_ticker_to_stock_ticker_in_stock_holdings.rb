class AlterTickerToStockTickerInStockHoldings < ActiveRecord::Migration
  def up
    change_column  :stock_holdings,  :ticker_id,  :stock_ticker_id
  end

  def down
    change_column  :stock_holdings,  :stock_ticker_id,  :ticker_id
  end
end
