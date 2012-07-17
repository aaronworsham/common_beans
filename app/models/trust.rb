module Trust

  MAX_TRUST_LEVEL = 5

  def trust!(user, level)
    $redis.multi do
      $redis.sadd(self.redis_key(:trusting), user.id)
      $redis.sadd(user.redis_key(:trusted_by), self.id)
    end
    self.set_clearance(user, level)
  end

  # distrust a user
  def distrust!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:trusting), user.id)
      $redis.srem(user.redis_key(:trusted_by), self.id)
    end
    clear_user_trust_level(user)
  end

  # users that self follows
  def trusting_user_ids
    user_ids = $redis.smembers(self.redis_key(:trusting))
    user_ids.reject{|x| x.to_i == self.id}
  end

  def trusting
    User.where(:id => trusting_user_ids)
  end

  # users that follow self
  def trusted_by_user_ids
    user_ids = $redis.smembers(self.redis_key(:trusted_by))
    user_ids.reject{|x| x.to_i == self.id}
  end

  def trusted_by
    User.where(:id => trusted_by_user_ids)
  end

  # users who follow and are being followed by self
  def friend_user_ids
    user_ids = $redis.sinter(self.redis_key(:trusting), self.redis_key(:trusted_by))
    user_ids.reject{|x| x.to_i == self.id}
  end

  def friends
    User.where(:id => friend_user_ids)

  end

  def invites_to
    user_ids = (self.trusting_user_ids - self.friend_user_ids)
    User.where(:id => user_ids)
  end

  def invites_from
    user_ids = (self.trusted_by_user_ids - self.friend_user_ids)
    User.where(:id => user_ids)
  end

  # does the user follow self
  def trusted_by?(user)
    return true if user === self
    $redis.sismember(self.redis_key(:trusted_by), user.id)
  end

  # does self trust user
  def trust?(user)
    return true if user === self
    $redis.sismember(self.redis_key(:trusting), user.id)
  end

  def distrust?(user)
    !trust?(user)
  end

  def mutual_trust?(user)
    trust?(user) and trusted_by?(user)
  end

  # number of followers
  def trusted_by_count
    $redis.scard(self.redis_key(:trusted_by))
  end

  # number of users being followed
  def trusting_count
    $redis.scard(self.redis_key(:trusting))
  end


  #clearance


  def has_clearance?(user, level)
    return false unless self.trust?(user)
    return false unless valid_trust_level(level)
    return false if level == 0
    (level..MAX_TRUST_LEVEL).each do |x|
      return true if try_trust_level(user, x)
    end
    false
  end

  def set_clearance(user, level)
    return nil unless valid_trust_level(level)
    clear_user_trust_level(user)
    set_trust_level(user, level)
  end

  def get_clearance(user)
    return false unless self.trust?(user)
    return MAX_TRUST_LEVEL if user === self
    (0..MAX_TRUST_LEVEL).each do |x|
      return x if try_trust_level(user, x)
    end
    0
  end


  private


  def clear_user_trust_level(user)
    (0..MAX_TRUST_LEVEL).each do |x|
      $redis.srem(self.redis_key("trust:level:#{x}"), user.id)
    end
  end

  def try_trust_level(user, level)
    return nil unless valid_trust_level(level)
    $redis.sismember(self.redis_key("trust:level:#{level}"), user.id)
  end

  def set_trust_level(user, level)
    return nil unless valid_trust_level(level)
    logger.info "TRUST: #{self.screen_name} now trusting #{user.screen_name} at level #{level}"
    $redis.sadd(self.redis_key("trust:level:#{level}"),user.id)
  end

  def valid_trust_level(level)
    return false unless level.is_a?(Integer)
    (0..MAX_TRUST_LEVEL).include?(level)
  end
end
