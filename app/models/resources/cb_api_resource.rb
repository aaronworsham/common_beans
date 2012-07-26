class CbApiResource < ActiveResource::Base
  self.site = "http://localhost:4567" 
  self.format = :json
  headers['X-CBToken'] = 'bob'
  def self.all_for_user(user)
    array = []
    self.json_for_user(user).each do |m|
      array << self.new(m)
    end
    array
  end

  def self.json_for_user(user)
    url = URI("http://localhost:4567/#{self.name.underscore.pluralize}.json?user=#{user.screen_name}&provider=#{user.provider}&token=#{user.get_auth_token}")
    data = Net::HTTP.get(url)
    json = JSON.parse(data)
  end

  def self.resource?
    true
  end
  def self.find_by_id(id)
    json = self.find_by_id_as_json(id)
    if json.present?
      self.new(json)
    else
      nil
    end
  end
  def self.find_by_id_as_json(id)
    self.get_as_json("http://localhost:4567/#{self.name.underscore.pluralize}/#{id}.json?")
  end 
  
  def self.find_by_id_and_user(id, user)
    json = self.find_by_id_and_user_as_json(id, user)
    self.new(json)
  end

  def self.find_by_id_and_user_as_json(id, user)
    self.get_as_json("http://localhost:4567/#{self.name.underscore.pluralize}/#{id}.json?user=#{user.screen_name}&provider=#{user.provider}&token=#{user.get_auth_token}")
  end
  
  def self.get_as_json(url)
    uri = URI(url)
    data = Net::HTTP.get(uri)
    if data != 'null'
      JSON.parse(data)
    else
      nil
    end
  end

  def user
    User.find_by_id(self.user_id)
  end
  def destroy
    url = URI("http://localhost:4567")
    net = Net::HTTP.new('localhost',4567)
    data = net.delete("/#{self.class.name.underscore.pluralize}/#{id}.json?user=#{user.screen_name}&provider=#{user.provider}&token=#{user.get_auth_token}")
    data
  end
end

  
