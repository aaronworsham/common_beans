
class window.ProfileTrustCollection extends Backbone.Collection
  model: TrustModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (f)->
    view = new ProfileTrustView({model:f});
    view.render();

class window.ProfileTrustedByCollection extends Backbone.Collection
  model: TrustModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (f)->
    view = new ProfileTrustedByView({model:f});
    view.render();



window.ProfileTrusts = new ProfileTrustCollection
window.ProfileTrusts.bind('reset', (trusts)->
    trusts.each( (f)->
      trusts.addOneView(f)
    );
);

window.ProfileTrustedBy = new ProfileTrustedByCollection
window.ProfileTrusts.bind('reset', (trusts)->
    trusts.each( (f)->
      trusts.addOneView(f)
    );
);
