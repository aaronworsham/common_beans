class CreateGroupPortfolios < ActiveRecord::Migration
  def change
    create_table  :group_portfolios do |t|
      t.integer   :user_id
      t.integer   :portfolio_id
      t.integer   :founder_group_id
      t.string    :type
      t.string    :state
      t.decimal   :investment,  :precision => 9,  :scale => 2
      t.float     :ownership
      t.timestamps
    end
  end
end
