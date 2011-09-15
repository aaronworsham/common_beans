class AddPortfolioToHolding < ActiveRecord::Migration
  def change
    rename_column   :holdings,    :profile_id,    :portfolio_id
  end
end
