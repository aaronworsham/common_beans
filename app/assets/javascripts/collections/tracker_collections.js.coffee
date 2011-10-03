
###
Tracker Collections
###


class window.TrackerHoldingCollection extends Backbone.Collection
  model: HoldingModel
  initialize: ->
    @bind('add', @addOneView);

  addOneView: (h)->
    view = new TrackerHoldingView({model:h});
    view_today = new TrackerHoldingTodayView({model:h});
    view.render();
    view_today.render();


window.TrackerHoldings = new TrackerHoldingCollection
window.TrackerHoldings.bind('reset', (holdings)->
    holdings.each( (h)->
      holdings.addOneView(h)
    );
);


class window.TrackerPortfolioCollection extends Backbone.Collection
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
     view = new TrackerPortfolioView({model:p});
     view.render();

window.TrackerPortfolios = new TrackerPortfolioCollection





class window.TrackerStockEventCollection extends Backbone.Collection
  model: StockEventModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
     view = new TrackerStockEventView({model:e});
     view.render();

window.TrackerStockEvents = new TrackerStockEventCollection
window.TrackerStockEvents.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);