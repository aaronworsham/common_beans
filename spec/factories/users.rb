FactoryGirl.define do
   factory :user do
     screen_name  Faker::Internet.user_name
     email        Faker::Internet.email
     name         Faker::Name.name
   end
   
   factory :twitter_user, :parent => :user do
     provider   'twitter'
     uid        '12345'
   end
   
   factory :facebook_user, :parent => :user do

   end
   
   factory :google_user, :parent => :user do

   end
 end
