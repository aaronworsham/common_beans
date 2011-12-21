class CreateFundHoldings < ActiveRecord::Migration
  def change
    create_table :fund_holdings do |t|
      t.decimal       :starting_units
      t.decimal       :starting_investment
      t.decimal       :net_investment
      t.decimal       :net_units
      t.integer       :user_id
      t.integer       :portfolio_id
      t.integer       :fund_ticker_id
      t.string        :current_state
      t.timestamps
    end
  end
end
