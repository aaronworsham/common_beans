Factory.define :buy do |f|
  f.association :ticker
  f.association :user 
  f.association :holding, :factory => :large_holding
  f.association :dow_index_eod
  f.shares rand(100)
  f.price rand(100)
  f.date_of_event Time.now
end
