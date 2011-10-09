Factory.define :holding do |f|
  f.starting_shares rand(10000)
  f.starting_price  rand(100.0)
  f.starting_investment {|f| f.starting_shares * f.starting_price}
  f.date_of_purchase {Time.at(Time.local(2000,1,1) + rand * (Time.now.to_f - Time.local(2000,1,1).to_f))}
  f.association :ticker
  f.association :user
  f.association :portfolio
  f.association :dow_index_eod
end

Factory.define :large_holding, :parent => :holding do |f|
  f.starting_shares  1000000
end
