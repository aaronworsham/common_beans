class Group

  MAX_MEMBER_COUNT = 5

  def initialize(founder, member_portfolio)
    @member_portfolio = member_portfolio
    @founder = founder
  end

  def add_user_and_portfolio(user)
    add_member(user)
    portfolio = create_group_portfolio(user)
    add_member_portfolio(portfolio)
    portfolio
  end

  def remove_user_and_portfolio(user, portfolio)
    remove_member(user)
    remove_member_portfolio(portfolio)
  end

  def member?(user)
    $redis.sismember(redis_key(:members), user.id)
  end

  def members
    user_ids = $redis.smembers(redis_key(:members))
    User.where(:id => user_ids)
  end

  def member_portfolio?(portfolio)
    $redis.sismember(redis_key(:member_portfolios), portfolio.id)
  end

  def member_portfolios
    portfolio_ids = $redis.smembers(redis_key(:member_portfolios))
    GroupPortfolio.where(:id => portfolio_ids)
  end

  def member_count
    $redis.scard(redis_key(:members))
  end


  private

  def add_member(user)
    if member?(user)
      raise GroupError::UserAlreadyMember
    elsif !@founder.mutual_trust?(user)
      raise GroupError::UserNotTrusted
    elsif member_count >= MAX_MEMBER_COUNT
      raise GroupError::GroupMaxMemberCount
    else
      $redis.sadd(redis_key(:members), user.id)
    end
  end

  def remove_member(user)
    $redis.srem(redis_key(:members), user.id)
  end

  def add_member_portfolio(member_portfolio)
    if member_portfolio?(member_portfolio)
      raise GroupError::PortfolioAlreadyListed
    else
      $redis.sadd(redis_key(:member_portfolios), member_portfolio.id)
    end
  end

  def remove_member_portfolio(member_portfolio)
    destroy_group_portfolio(member_portfolio)
    $redis.srem(redis_key(:member_portfolios), member_portfolio.id)
  end
  

  def create_group_portfolio(user)
    GroupPortfolio.create(  :user => user,
                            :founder_group => @member_portfolio
    )
  end

  def destroy_group_portfolio(portfolio)
    portfolio.destroy
  end


  def redis_key(key)
    "groups:#{@member_portfolio}:#{key}"
  end
end
