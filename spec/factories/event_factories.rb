FactoryGirl.define do

  factory :stock_buy do
    shares {rand(10000)}
    price  {rand(100.0)}
    investment {|f| f.shares * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :stock_ticker
    association :user
  end
  factory :stock_sell do
    shares {rand(10000)}
    price  {rand(100.0)}
    roi {|f| f.shares * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :stock_ticker
    association :user
  end
  factory :fund_buy do
    units {rand(10000)}
    price  {rand(100.0)}
    investment {|f| f.units * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :fund_ticker
    association :user
  end
  factory :fund_sell do
    units {rand(10000)}
    price  {rand(100.0)}
    roi {|f| f.units * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :fund_ticker
    association :user
  end
  factory :etf_buy do
    units {rand(10000)}
    price  {rand(100.0)}
    investment {|f| f.units * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :etf_ticker
    association :user
  end
  factory :etf_sell do
    units {rand(10000)}
    price  {rand(100.0)}
    roi {|f| f.units * f.price}
    executed_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :etf_ticker
    association :user
  end

end