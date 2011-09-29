(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.Friend = (function() {
    __extends(Friend, Backbone.Model);
    function Friend() {
      Friend.__super__.constructor.apply(this, arguments);
    }
    Friend.prototype.urlRoot = "/friends";
    return Friend;
  })();
  window.FriendView = (function() {
    __extends(FriendView, Backbone.View);
    function FriendView() {
      FriendView.__super__.constructor.apply(this, arguments);
    }
    FriendView.prototype.tagName = "div";
    FriendView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.render, this);
      return this.model.bind('destroy', this.remove, this);
    };
    FriendView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.add_friend_template(this.model.toJSON()));
      $(elem).hide();
      $('#friend-content').append(elem);
      return $(elem).fadeIn("slow");
    };
    FriendView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return FriendView;
  })();
  window.FriendCollection = (function() {
    __extends(FriendCollection, Backbone.Collection);
    function FriendCollection() {
      FriendCollection.__super__.constructor.apply(this, arguments);
    }
    FriendCollection.prototype.model = Friend;
    FriendCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    FriendCollection.prototype.addOneView = function(f) {
      var view;
      view = new FriendView({
        model: f
      });
      return view.render();
    };
    return FriendCollection;
  })();
  window.Friends = new FriendCollection;
  window.Friends.bind('reset', function(friends) {
    return friends.each(function(f) {
      return friends.addOneView(f);
    });
  });
}).call(this);
