class AddFundFieldsToFundTickers < ActiveRecord::Migration
  def change
    add_column :fund_tickers, :category, :string
    add_column :fund_tickers, :family, :string
    add_column :fund_tickers, :inception_date, :string
    add_column :fund_tickers, :summary, :text
  end
end
