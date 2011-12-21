class Profile < ActiveRecord::Base
  has_many :stock_holdings, :dependent => :destroy
  belongs_to :user
end
