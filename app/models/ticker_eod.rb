class TickerEod < ActiveRecord::Base
  belongs_to :ticker

  def close
    50.0
  end
end
