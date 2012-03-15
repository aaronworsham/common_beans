

FactoryGirl.define do
  factory :portfolio do
    name Faker::Name.name
    user
    trust_level 3
  end
end
