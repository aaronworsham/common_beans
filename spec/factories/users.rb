 Factory.define :user do |f|
   f.screen_name Faker::Internet.user_name
   f.email Faker::Internet.email
 end
