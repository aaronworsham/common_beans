class AddClosedAtToTickerEod < ActiveRecord::Migration
  def change
    add_column  :ticker_eods,   :closed_on,     :date
  end
end
