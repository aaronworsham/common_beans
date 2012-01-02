# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :multi_holding_allocation do
    association :fund_ticker
  end
end
