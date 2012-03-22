

FactoryGirl.define do
  factory :portfolio do
    name Faker::Name.name
    user
    portfolio_plan
    portfolio_strategy
  end
end
