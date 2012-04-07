
# Stocks

class window.StockHoldingCollection extends Backbone.Collection
  model: StockHoldingModel
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
    view = new StockHoldingView({model:h});
    view.render();


window.StockHoldings = new StockHoldingCollection
window.StockHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);


class window.StockBuyCollection extends Backbone.Collection
  model: StockBuyModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (h)->
    view = new StockBuyView({model:h});
    view.render();



window.StockBuys = new StockBuyCollection
window.StockBuys.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);

class window.StockSellCollection extends Backbone.Collection
  model: StockSellModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (h)->
    view = new StockSellView({model:h});
    view.render();

window.StockSells = new StockSellCollection
window.StockSells.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);



# Funds

class window.FundHoldingCollection extends Backbone.Collection
  model: FundHoldingModel
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
    view = new FundHoldingView({model:h});
    view.render();


window.FundHoldings = new FundHoldingCollection
window.FundHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);


class window.FundBuyCollection extends Backbone.Collection
  model: FundBuyModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
     view = new FundBuyView({model:e});
     view.render();

window.FundBuys = new FundBuyCollection
window.FundBuys.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);

class window.FundSellCollection extends Backbone.Collection
  model: FundSellModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
     view = new FundSellView({model:e});
     view.render();

window.FundSells = new FundSellCollection
window.FundSells.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);



# Etf

class window.EtfHoldingCollection extends Backbone.Collection
  model: EtfHoldingModel
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
    view = new EtfHoldingView({model:h});
    view.render();


window.EtfHoldings = new EtfHoldingCollection
window.EtfHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);


class window.EtfBuyCollection extends Backbone.Collection
  model: EtfBuyModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
     view = new TrackerEtfEventView({model:e});
     view.render();

window.EtfBuys = new EtfBuyCollection
window.EtfBuys.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);

class window.EtfSellCollection extends Backbone.Collection
  model: EtfSellModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
     view = new TrackerEtfEventView({model:e});
     view.render();

window.EtfSells = new EtfSellCollection
window.EtfSells.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);



# Bonds

class window.BondHoldingCollection extends Backbone.Collection
  model: BondHoldingModel
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
    view = new BondHoldingView({model:h});
    view.render();


window.BondHoldings = new BondHoldingCollection
window.BondHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);


# Cds

class window.CdHoldingCollection extends Backbone.Collection
  model: CdHoldingModel
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
    view = new CdHoldingView({model:h});
    view.render();


window.CdHoldings = new CdHoldingCollection
window.CdHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);


# Multi

class window.MultiHoldingCollection extends Backbone.Collection
  model: MultiHoldingModel
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
    view = new MultiHoldingView({model:h});
    view.render();


window.MultiHoldings = new MultiHoldingCollection
window.MultiHoldings.bind('reset', (events)->
     events.each( (e)->
       events.addOneView(e)
     );
);




class window.PortfolioCollection extends Backbone.Collection
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
    new PortfolioView({model:p}).render();
    new HotlistPortfolioView({model:p}).render();

window.Portfolios = new PortfolioCollection

