FactoryGirl.define do |f|
  factory :ticker_eod do
    close {rand(100)}
    high {rand(100)}
    low {rand(100)}
    open {rand(100)}
    association :ticker
  end
end