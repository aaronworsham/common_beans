class TickerEodResource < ActiveResource::Base
  self.site = "http://localhost:3000/"
  self.element_name = "ticker_eod"
end