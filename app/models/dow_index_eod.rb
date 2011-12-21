class DowIndexEod < ActiveRecord::Base
  has_many :stock_holdings
end
