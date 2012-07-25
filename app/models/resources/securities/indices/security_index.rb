class SecurityIndex < ActiveRecord::Base
  include Quotable
  include TickerLiquidity
  include DateMixin
  include Tradeable

  has_many :index_eods

  def ticker
    self
  end

  def ticker_eods
    index_eods
  end

  def has_price?
    true
  end

  def create_eod(eod, date)
    IndexEod.create(
      :security_index => self,
      :high => eod[:high],
      :low =>  eod[:low],
      :open => eod[:open],
      :close => eod[:close],
      :closed_on => date
    ).close
  end

  def index_gain_ratio(date)
    calculate_value_gain_ratio(date, Date.today)
  end

  def net_denomination
    1
  end

  def past_denomination(date)
    1
  end

  def self.gains_since(date)
    hash = Hash.new
    %w(Dow Sp500 SpMidcap NasdaqComposite AmexComposite NyseUs100 Russell2000 SpComposite).each do |i|
      index =  Object.const_get(i+'Index').first
      if index
        hash[i] = index.index_gain_ratio(date)
      else
        Object.const_get(i+'Index').create.index_gain_ratio(date)
      end
    end
    hash
  end
end
