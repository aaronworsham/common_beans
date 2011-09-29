###
Tracker Models
###

class window.TrackerPortfolio extends Backbone.Model
  urlRoot : "/portfolios"

class window.TrackerHolding extends Backbone.Model
  urlRoot : "/holdings"


class window.TrackerStockEvent extends Backbone.Model
  urlRoot : "/events"