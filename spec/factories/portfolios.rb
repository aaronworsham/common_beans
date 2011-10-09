Factory.define :portfolio do |f|
  f.name Faker::Name.name
  f.association :user
end
