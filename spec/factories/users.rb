 Factory.define :user do |f|
   f.screename Faker::Internet.user_name
   f.email Faker::Internet.email
 end
