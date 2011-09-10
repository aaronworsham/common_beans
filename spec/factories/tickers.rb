
Factory.define :ticker do |f|

  f.symbol {
      letters = %Q(ABCDEFJHIJKLMNOPQRSTUVWXYZ)
      symbol = []
      rand(4).times do |x|
        symbol << letters[rand(26)]
      end
      symbol.join
  }
  f.name Faker::Name.name
  f.association :exchange
end


