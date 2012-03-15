class AddFieldsToHoldings < ActiveRecord::Migration
  def change
    %w(stock fund etf bond cd).each do |t|
      %w(d7 d30 d180 d365 y2 y3 y4 y5).each do |x|
        add_column "#{t}_holdings".to_sym,  "#{x}_value".to_sym, :float
        add_column "#{t}_holdings".to_sym,  "#{x}_gain".to_sym, :float
      end
    end
  end
end
