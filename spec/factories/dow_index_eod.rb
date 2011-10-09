FactoryGirl.define do
  factory :dow_index_eod do
    closed_on Date.parse('01/01/2011')
    close 47
    net_change 3
  end

end