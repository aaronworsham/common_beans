class CreateFinancialAdvices < ActiveRecord::Migration
  def change
    create_table :financial_advice do |t|
      t.integer :user_id
      t.integer :financial_adviser_id
      t.timestamps
    end
  end
end
