

FactoryGirl.define do

  factory :stock_holding do
    starting_shares {rand(10000)}
    starting_price  {rand(100.0)}
    starting_investment {|f| f.starting_shares * f.starting_price}
    purchased_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :stock_ticker
    association :user
    association :portfolio
  end

  factory :large_stock_holding, :parent => :stock_holding do
    starting_shares  1000000
  end

  factory :fund_holding do
    starting_units {rand(10000)}
    starting_price  {rand(100.0)}
    starting_investment {|f| f.starting_units * f.starting_price}
    purchased_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :fund_ticker
    association :user
    association :portfolio
  end

  factory :etf_holding do
    starting_units {rand(10000)}
    starting_price  {rand(100.0)}
    starting_investment {|f| f.starting_units * f.starting_price}
    purchased_at {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
    association :etf_ticker
    association :user
    association :portfolio
  end

  factory :bond_holding do
    face_value {rand(10000)}
    purchase_price {|f| f.face_value}
    matures_at {10.years.from_now}
    expected_yield {0.05}
    coupon {0.05}
    frequency {1}
    quantity {1}
    purchased_at {Time.now}
    association :user
    association :portfolio
  end

  factory :cd_holding do
    face_value {rand(10000)}
    purchase_price {|f| f.face_value}
    matures_at {10.years.from_now}
    expected_yield {0.05}
    coupon {0.05}
    frequency {1}
    quantity {1}
    purchased_at {Time.now}
    association :user
    association :portfolio
  end

end
