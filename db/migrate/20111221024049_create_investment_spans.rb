class CreateInvestmentSpans < ActiveRecord::Migration
  def change
    create_table :investment_spans do |t|
      t.date      :start_date
      t.date      :end_date
      t.decimal   :opening_balance
      t.decimal   :closing_balance
      t.decimal   :units
      t.integer   :user_id
      t.integer   :fund_holding_id
      t.timestamps
    end
  end
end
