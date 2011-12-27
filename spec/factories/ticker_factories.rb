FactoryGirl.define do
  sequence :symbol do |n|
    "ABC#{n}"
  end
end

FactoryGirl.define do |f|
  factory :stock_ticker do
    symbol
    name Faker::Name.name
    association :exchange
    after_create{|ticker| StockTickerEod.create(:stock_ticker => ticker, :close => 100, :closed_on => Date.today)}
  end
  factory :fund_ticker do
    symbol
    name Faker::Name.name
    after_create{|ticker| FundTickerEod.create(:fund_ticker => ticker, :close => 100, :closed_on => Date.today)}
  end
  factory :etf_ticker do
    symbol
    name Faker::Name.name
    after_create{|ticker| EtfTickerEod.create(:etf_ticker => ticker, :close => 100, :closed_on => Date.today)}
  end

end


