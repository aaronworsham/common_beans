

class window.DashboardPortfolioCollection extends Backbone.Collection
  model: PortfolioModel

  initialize: ->
     @bind('add', (portfolio)->
       @addOneView(portfolio)
     );
     @bind('reset', (portfolios)->
       portfolios.each( (p)->
         portfolios.addOneView(p)
       );
     );


  addOneView: (p)->
    view = new DashboardPortfolioView({model:p});
    view.render();



window.DashboardPortfolios = new DashboardPortfolioCollection



class window.DashboardHoldingCollection extends Backbone.Collection
  model: HoldingModel
  initialize: ->
     @bind('add', (holding)->
       @addOneView(holding)
     );
     @bind('reset', (holdings)->
       holdings.each( (h)->
         holdings.addOneView(h)
       );
     );

  addOneView: (h)->
    view = new DashboardHoldingView({model:h});
    view.render();



window.DashboardHoldings = new DashboardHoldingCollection

