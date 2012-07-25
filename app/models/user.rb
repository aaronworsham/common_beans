class User < ActiveRecord::Base
  include AASM
  include Trust


  has_many :user_roles
  has_many :roles,              :through => :user_roles
  has_many :financial_adviser_invites

  attr_accessor :token, :passcode

  aasm_column :current_state

  aasm_initial_state :active

  aasm_state :active
  aasm_state :inactive


  serialize :urls

  %w(portfolios stock_holdings stock_events fund_holdings fund_events etf_holdings etf_events multi_holdings multi_statements).each do |m|
    define_method m do
      Object.const_get(m.classify).all_for_user(self)
    end
    define_method "#{m}_as_json" do
      Object.const_get(m.classify).json_for_user(self)
    end
  end


  def self.create_with_omniauth(auth)  
    user = create! do |user|
      provider = Provider.new(auth)
      user.provider = provider.source
      user.uid = provider.uid
      user.screen_name = (auth['info']['nickname'] || auth['info']['name'])
      user.name = auth['info']['name']
      user.image_url =  auth['info']['image_url']
      user.location = auth['info']['location']
      user.description = auth['info']['description']
      user.urls = auth['info']['urls']
    end  
    first_friend = User.find_by_screen_name('aaronworsham')
    if first_friend 
      user.trust!(first_friend, 5)
      first_friend.trust!(user, 5)
    end
    user
  rescue => e
    p 'INSIDE USER CREATE'
    p e.message
  end

  def friend_reader
    MessageFriend.reader(self.id)
  end

  def friend_messages
    self.friend_reader.read(20)
  end

  def create_friend_message(user, txt)
    return false unless self.mutual_trust?(user)
    return false if user == self
    MessageFriend.new(
      :text => txt,
      :action => 'test',
      :user => self,
      :friend => user
    ).save
  end

  def group_messages
    messages = []
    group_portfolios.each do |gp|
      gp.group_reader.read(20).each do |m|
        messages << JSON.parse(m)
      end
    end
    messages.sort{|x| x['date']}
  end

  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end

  def backbone_models
    hash = {}
    hash['portfolios'] = self.portfolios_as_json
    %w( stock_holdings
        fund_holdings
        etf_holdings).each do |x|
      hash[x] = self.send("#{x}_as_json")
    end
        hash['multi_holdings'] = self.multi_holdings_as_json
        hash['multi_statements'] = self.multi_statements_as_json
    %w( fund_events
        etf_events
        stock_events).each do |x|
      hash[x] = self.send("#{x}_as_json")
    end
   return hash
  end

  def all_as_json
    url = URI("http://localhost:4567/all.json?user=#{self.screen_name}&provider=#{self.provider}&token=#{self.get_auth_token}")
    data = Net::HTTP.get(url)
    json = JSON.parse(data)

  end



  def friend_backbone_models
    hash = {}
    friends = self.friends
    friends.each do |f|
      hash[f.id] = Portfolio.safe_backbone_models(f, self)
    end
    hash
  end

  def get_auth_token
    $redis.get("token:#{self.provider}:#{self.screen_name}")
  end

  def set_auth_token
    $redis.set("token:#{self.provider}:#{self.screen_name}", SecureRandom.urlsafe_base64(10))
  end


end
