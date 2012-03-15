FactoryGirl.define do
  factory :stock_ticker_eod do
    close {rand(100)}
    high {rand(100)}
    low {rand(100)}
    open {rand(100)}
    association :stock_ticker
  end
  factory :fund_ticker_eod do
    close {rand(100)}
    high {rand(100)}
    low {rand(100)}
    open {rand(100)}
    association :fund_ticker
  end
  factory :etf_ticker_eod do
    close {rand(100)}
    high {rand(100)}
    low {rand(100)}
    open {rand(100)}
    association :etf_ticker
  end

end