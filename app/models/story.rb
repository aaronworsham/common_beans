class Story < ActiveResource::Base
  PROJECT_ID = 525695
  TOKEN = '092553ab83529bab6e2501760cca4aad'
  self.site = "http://www.pivotaltracker.com/services/v3/projects/#{PROJECT_ID}"
  headers['X-TrackerToken'] = TOKEN
  self.format = :xml

  def full_name
    if self.respond_to?('deadline')
      self.name.capitalize + "  ~ #{self.deadline}"
    else
      self.name.capitalize
    end
  end

  def full_labels
    if self.respond_to?('labels')
      self.labels
    else
      ''
    end
  end
end
