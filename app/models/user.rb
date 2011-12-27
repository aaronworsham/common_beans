class User < ActiveRecord::Base
  include AASM
  include Trust

  has_many :group_portfolios, :dependent => :destroy
  has_many :portfolios,       :dependent => :destroy
  has_many :stock_holdings,   :dependent => :destroy
  has_many :fund_holdings,    :dependent => :destroy
  has_many :buys,             :dependent => :destroy
  has_many :sells,            :dependent => :destroy
  has_many :events,           :dependent => :destroy

  aasm_column :current_state

  aasm_initial_state :active

  aasm_state :active
  aasm_state :inactive


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

  def holdings
    stock_holdings + fund_holdings
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


end
