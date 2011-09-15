class User < ActiveRecord::Base
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
  


  def follow!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:following), user.id)
      $redis.sadd(user.redis_key(:followers), self.id)
    end
  end
  # unfollow a user
  def unfollow!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:following), user.id)
      $redis.srem(user.redis_key(:followers), self.id)
    end
  end
  # users that self follows
  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(:id => user_ids)
  end
  # users that follow self
  def following
    user_ids = $redis.smembers(self.redis_key(:following))
    User.where(:id => user_ids)
  end
  # users who follow and are being followed by self
  def friends
    user_ids = $redis.sinter(self.redis_key(:following), self.redis_key(:followers))
    User.where(:id => user_ids)
  end
  # does the user follow self
  def followed_by?(user)
    $redis.sismember(self.redis_key(:followers), user.id)
  end
  # does self follow user
  def following?(user)
    $redis.sismember(self.redis_key(:following), user.id)
  end
  # number of followers
  def followers_count
    $redis.scard(self.redis_key(:followers))
  end
  # number of users being followed
  def following_count
    $redis.scard(self.redis_key(:following))
  end
  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end


end
