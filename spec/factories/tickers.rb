FactoryGirl.define do
  sequence :symbol do |n|
    "ABC#{n}"
  end
end

FactoryGirl.define do |f|
  factory :ticker do
    symbol
    name Faker::Name.name
    association :exchange
    after_create{|ticker| TickerEod.create(:ticker => ticker, :close => 100, :closed_on => Date.today)}
  end

end


