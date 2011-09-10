Factory.define :holding do |f|
  f.starting_shares rand(10000)
  f.starting_price  rand(100.0)
  f.association :ticker
  f.association :user
  f.association :profile
end

Factory.define :large_holding, :parent => :holding do |f|
  f.starting_shares  1000000
end
