class window.DashboardMessageCollection extends Backbone.Collection
  model: MessageModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new DashboardMessageView({model:p});
    view.render();




window.Messages = new DashboardMessageCollection
window.Messages.bind('reset', (messages)->
    messages.each( (m)->
      messages.addOneView(m)
    );
);

class window.PortfolioCollection extends Backbone.Collection
  model: PortfolioModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new DashboardPortfolioView({model:p});
    view.render();



window.DashboardPortfolios = new PortfolioCollection
window.DashboardPortfolios.bind('reset', (portfolios)->
    portfolios.each( (p)->
      portfolios.addOneView(p)
    );
);


class window.DashboardHoldingCollection extends Backbone.Collection
  model: HoldingModel
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (h)->
    view = new DashboardHoldingView({model:h});
    view_today = new DashboardHoldingTodayView({model:h});
    view.render();
    view_today.render();



window.DashboardHoldings = new DashboardHoldingCollection
window.DashboardHoldings.bind('reset', (holdings)->
    holdings.each( (h)->
      holdings.addOneView(h)
    );
);
