class TickerResource < ActiveResource::Base
  self.site = "http://localhost:3000/"
  self.element_name = "ticker"
end