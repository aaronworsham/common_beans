$ ->
  $('.follow-user').click( ->
    friend = new Friend({id:window.friendId})
    friend.save();          
  );

