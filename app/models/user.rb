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
  


  def trust!(user, level)
    $redis.multi do
      $redis.sadd(self.redis_key(:trusting), user.id)
      $redis.sadd(user.redis_key(:trusted_by), self.id)
    end
    self.set_clearance(user, level)
  end
  # unfollow a user
  def untrust!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:trusting), user.id)
      $redis.srem(user.redis_key(:trusted_by), self.id)
    end
  end
  # users that self follows
  def trusting
    user_ids = $redis.smembers(self.redis_key(:trusting))
    User.where(:id => user_ids)
  end
  # users that follow self
  def trusted_by
    user_ids = $redis.smembers(self.redis_key(:trusted_by))
    User.where(:id => user_ids)
  end
  # users who follow and are being followed by self
  def friends
    user_ids = $redis.sinter(self.redis_key(:trusting), self.redis_key(:trusted_by))
    User.where(:id => user_ids)
  end
  # does the user follow self
  def trusted_by?(user)
    $redis.sismember(self.redis_key(:trusted_by), user.id)
  end
  # does self follow user
  def trusting?(user)
    $redis.sismember(self.redis_key(:trusting), user.id)
  end
  # number of followers
  def trusted_by_count
    $redis.scard(self.redis_key(:trusted_by))
  end
  # number of users being followed
  def trusting_count
    $redis.scard(self.redis_key(:trusting))
  end
  def has_clearance?(user, level)
    return false unless self.trusting?(user)
    return false if level == 0
    (level..10).each do |x|
      return true if $redis.sismember(self.redis_key("trust:level:#{x}"), user.id)
    end
    return false
  end
  def set_clearance(user, level)
    self.clear_user_clearance(user, level)
    $redis.sadd(self.redis_key("trust:level:#{level}"),user.id)
  end
  def clear_user_clearance(user, level)
    (0..10).each do |x|
      $redis.srem(self.redis_key("trust:level:#{level}"), user.id)
    end
  end
  def trust_level(user)
    return false unless self.trusting?(user)
    (0..10).each do |x|
      return x if $redis.sismember(self.redis_key("trust:level:#{x}"), user.id)
    end
    return 0
  end
  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end


end
