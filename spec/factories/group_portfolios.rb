# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_portfolio do
    user { Factory :user }
    portfolio { Factory :portfolio }
    founder_group {Factory :compare_group}
  end

  factory :compare_group do
    user { Factory :user }
    portfolio { Factory :portfolio }
    is_lead true
  end

  factory :share_group do
    user { Factory :user }
    portfolio { Factory :portfolio }
    is_lead true
  end
end
