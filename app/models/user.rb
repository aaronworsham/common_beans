class User < ActiveRecord::Base

  include Trust

  has_many :groups
  has_many :clubs
  has_many :portfolios
  has_many :holdings
  has_many :buys
  has_many :sells
  has_many :events

  serialize :urls
  def self.create_with_omniauth(auth)  
    create! do |user|  
      provider = Provider.new(auth)
      user.provider = provider.source
      user.uid = provider.uid 
      user.screen_name = provider.screen_name
      user.name = provider.name
      user.image_url =  provider.image_url
      user.location = provider.location
      user.description = provider.description
      user.urls = provider.urls
    end  
  end

  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end


end
