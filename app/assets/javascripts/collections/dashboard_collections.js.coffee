securities = ['stock', 'fund', 'etf', 'multi']

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
        h.view = view
        view.render();

    window[capSecurity+'Holdings'] = new window[capSecurity+'HoldingCollection']
    window[capSecurity+'Holdings'].bind('reset', (events)->
         events.each( (e)->
           events.addOneView(e)
         );
    );

    class window[capSecurity+'BuyCollection'] extends Backbone.Collection
      model: window[capSecurity+'BuyModel']
    
    window[capSecurity+'Buys'] = new window[capSecurity+'BuyCollection']
 
     
    class window[capSecurity+'SellCollection'] extends Backbone.Collection
      model: window[capSecurity+'SellModel']
    
    
    window[capSecurity+'Sells'] = new window[capSecurity+'SellCollection']


    class window[capSecurity+'EventCollection'] extends Backbone.Collection
      model: window[capSecurity+'EventModel']
      initialize: ->
        @bind('add', @addOneView, this);
    
      addOneView: (h)->
        view = new window[capSecurity+'EventView']({model:h});
        h.view = view
        view.render();

    window[capSecurity+'Events'] = new window[capSecurity+'EventCollection']
    window[capSecurity+'Events'].bind('reset', (events)->
         events.each( (e)->
           events.addOneView(e)
         );
    );

    class window[capSecurity+'HoldingChartCollection'] extends Backbone.Collection
      model: window[capSecurity+'HoldingModel']
      initialize: ->
        @bind('add', @addOneView, this);
    
      addOneView: (h)->
        view = new window[capSecurity+'HoldingChartView']({model:h});
        h.view = view
        view.render();

    window[capSecurity+'HoldingCharts'] = new window[capSecurity+'HoldingChartCollection']
    window[capSecurity+'HoldingCharts'].bind('reset', (events)->
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
    for alloc in p.attributes.multi_allocations
      do (alloc) ->
        model = new MultiAllocationModel(alloc)
        MultiAllocations.add(model)

window.MultiStatements = new MultiStatementCollection

class window.MultiAllocationCollection extends Backbone.Collection
  model: MultiAllocationModel

  initialize: ->
     @bind('add', (alloc)->
       @addOneView(alloc)
     );
     @bind('reset', (allocations)->
       allocations.each( (p)->
         allocation.addOneView(p)
       );
     );


  addOneView: (p)->
    new MultiAllocationView({model:p}).render();

window.MultiAllocations = new MultiAllocationCollection

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
class window.CompareValuesCollection extends Backbone.Collection
  model: CompareValuesModel

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
    new CompareValuesView({model:p}).render();

window.ValueComparisons = new CompareValuesCollection

class window.CompareFriendsCollection extends Backbone.Collection
  model: CompareFriendsModel

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
    new CompareFriendsView({model:p}).render();

window.FriendComparisons = new CompareFriendsCollection

class window.CompareOthersCollection extends Backbone.Collection
  model: CompareOthersModel

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
    new CompareOthersView({model:p}).render();

window.OtherComparisons = new CompareOthersCollection

class window.FriendPortfolioCollection extends Backbone.Collection
  model: FriendPortfolioModel

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
    new FriendPortfolioView({model:p}).render();

window.FriendPortfolios = new FriendPortfolioCollection

class window.FriendsCollection extends Backbone.Collection
  model: FriendModel

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
    new FriendView({model:p}).render();

window.Friends = new FriendsCollection

window.addFriends = (friends)->
  for f in friends
    do (f)->
      Friends.add(f.user)

class window.ToInvitesCollection extends Backbone.Collection
  model: InviteToModel

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
    new InviteToView({model:p}).render();

window.ToInvites = new ToInvitesCollection

class window.FromInvitesCollection extends Backbone.Collection
  model: InviteFromModel

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
    new InviteFromView({model:p}).render();

window.FromInvites = new FromInvitesCollection
