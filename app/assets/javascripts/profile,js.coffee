###
= require application
= require models/profile_models
= require views/profile_views
= require collections/profile_collections
###

$ ->
  $('.follow-user').click( ->
    friend = new Friend({id:window.friendId})
    friend.save();
  );
