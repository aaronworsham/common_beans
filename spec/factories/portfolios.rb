Factory.define :portfolio do |f|
  f.name Faker::Name.name
  f.user :user
  f.trust_level 3
end
