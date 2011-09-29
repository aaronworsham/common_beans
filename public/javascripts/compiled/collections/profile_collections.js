(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.ProfileFriendCollection = (function() {
    __extends(ProfileFriendCollection, Backbone.Collection);
    function ProfileFriendCollection() {
      ProfileFriendCollection.__super__.constructor.apply(this, arguments);
    }
    ProfileFriendCollection.prototype.model = FriendModel;
    ProfileFriendCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    ProfileFriendCollection.prototype.addOneView = function(f) {
      var view;
      view = new FriendView({
        model: f
      });
      return view.render();
    };
    return ProfileFriendCollection;
  })();
  window.ProfileFriends = new ProfileFriendCollection;
  window.ProfileFriends.bind('reset', function(friends) {
    return friends.each(function(f) {
      return friends.addOneView(f);
    });
  });
}).call(this);
