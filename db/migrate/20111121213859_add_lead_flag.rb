class AddLeadFlag < ActiveRecord::Migration
  def up
    add_column    :group_portfolios,     :is_lead,   :boolean,     :default => :false
  end

  def down
    remove_column     :group_portfolios,   :is_lead
  end
end
