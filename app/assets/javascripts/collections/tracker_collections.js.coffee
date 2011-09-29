
###
Tracker Collections
###


class window.TrackerHoldingCollection extends Backbone.Collection
  model: TrackerHolding
  initialize: ->
    @bind('add', @addOneView, this);

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
   model: TrackerPortfolio

   initialize: ->
     @bind('add', @addOneView, this);

   addOneView: (p)->
     view = new TrackerPortfolioView({model:p});
     view.render();

window.TrackerPortfolios = new TrackerPortfolioCollection
window.TrackerPortfolios.bind('reset', (portfolios)->
     portfolios.each( (p)->
       portfolios.addOneView(p)
     );
);




class window.TrackerStockEventCollection extends Backbone.Collection
  model: TrackerStockEvent
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