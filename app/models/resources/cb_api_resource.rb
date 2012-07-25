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
end

  
