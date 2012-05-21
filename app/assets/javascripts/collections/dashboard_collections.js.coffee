securities = ['stock', 'fund', 'bond', 'etf', 'cd', 'multi']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingCollection'] extends Backbone.Collection
      model: window[capSecurity+'HoldingModel']
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
        view = new window[capSecurity+'HoldingView']({model:h});
        view.render();

    window[capSecurity+'Holdings'] = new window[capSecurity+'HoldingCollection']
    window[capSecurity+'Holdings'].bind('reset', (events)->
         events.each( (e)->
           events.addOneView(e)
         );
    );

    class window[capSecurity+'BuyCollection'] extends Backbone.Collection
      model: window[capSecurity+'BuyModel']
      initialize: ->
        @bind('add', @addOneView, this);
    
      addOneView: (h)->
        view = new window[capSecurity+'BuyView']({model:h});
        view.render();
    
    
    
    window[capSecurity+'Buys'] = new window[capSecurity+'BuyCollection']
    window[capSecurity+'Buys'].bind('reset', (events)->
         events.each( (e)->
           events.addOneView(e)
         );
    );    
    
    class window[capSecurity+'SellCollection'] extends Backbone.Collection
      model: window[capSecurity+'SellModel']
      initialize: ->
        @bind('add', @addOneView, this);
    
      addOneView: (h)->
        view = new window[capSecurity+'SellView']({model:h});
        view.render();
    
    
    
    window[capSecurity+'Sells'] = new window[capSecurity+'SellCollection']
    window[capSecurity+'Sells'].bind('reset', (events)->
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

class window.MultiStatementCollection extends Backbone.Collection
  model: MultiStatementModel

  initialize: ->
     @bind('add', (statement)->
       @addOneView(statement)
     );
     @bind('reset', (statements)->
       statements.each( (p)->
         statements.addOneView(p)
       );
     );


  addOneView: (p)->
    new MultiStatementView({model:p}).render();

window.MultiStatements = new MultiStatementCollection

class window.CompareIndicesCollection extends Backbone.Collection
  model: CompareIndicesModel

  initialize: ->
     @bind('add', (statement)->
       @addOneView(statement)
     );
     @bind('reset', (statements)->
       statements.each( (p)->
         statements.addOneView(p)
       );
     );


  addOneView: (p)->
    new CompareIndicesView({model:p}).render();

window.IndexComparisons = new CompareIndicesCollection


