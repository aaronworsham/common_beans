class AddDateOfEventToBuySell < ActiveRecord::Migration
  def change
    add_column :buys, :date_of_event, :datetime
    add_column :sells, :date_of_event, :datetime
  end
end
