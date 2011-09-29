
class window.ProfileFriendCollection extends Backbone.Collection
  model: Friend

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (f)->
    view = new FriendView({model:f});
    view.render();



window.ProfileFriends = new ProfileFriendCollection
window.ProfileFriends.bind('reset', (friends)->
    friends.each( (f)->
      friends.addOneView(f)
    );
);
