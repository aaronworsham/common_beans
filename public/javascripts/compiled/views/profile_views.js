(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.ProfileFriendView = (function() {
    __extends(ProfileFriendView, Backbone.View);
    function ProfileFriendView() {
      ProfileFriendView.__super__.constructor.apply(this, arguments);
    }
    ProfileFriendView.prototype.tagName = "div";
    ProfileFriendView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.render, this);
      return this.model.bind('destroy', this.remove, this);
    };
    ProfileFriendView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.add_friend_template(this.model.toJSON()));
      $(elem).hide();
      $('#friend-content').append(elem);
      return $(elem).fadeIn("slow");
    };
    ProfileFriendView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return ProfileFriendView;
  })();
}).call(this);
