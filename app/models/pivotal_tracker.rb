class StoryResource < ActiveResource::Base
  PROJECT_ID = 525695
  TOKEN = '092553ab83529bab6e2501760cca4aad'
  self.site = "http://www.pivotaltracker.com/services/v3/projects/#{PROJECT_ID}/"
  self.element_name = 'story'
  headers['X-TrackerToken'] = TOKEN
end

