class Ticker < ActiveRecord::Base
  has_many :holdings
  belongs_to :exchange
end
