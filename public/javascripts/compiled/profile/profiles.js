(function() {
  $(function() {
    return $('.follow-user').click(function() {
      var friend;
      friend = new Friend({
        id: window.friendId
      });
      return friend.save();
    });
  });
}).call(this);
