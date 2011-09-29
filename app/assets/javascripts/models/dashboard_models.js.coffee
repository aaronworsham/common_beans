


class window.DashboardHolding extends Backbone.Model
  initialize: ->
    @portfolio = DashboardPortfolios.get(@get('portfolio_id'));

  urlRoot : "/holdings"


class window.DashboardPortfolio extends Backbone.Model
  urlRoot : "/portfolios"


class window.DashbaordMessage extends Backbone.Model
  urlRoot : "/messages"
