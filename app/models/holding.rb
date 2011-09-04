class Holding < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticker

  after_create :notify_everyone


end
