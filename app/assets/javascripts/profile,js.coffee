###
= require jquery
= require jquery-ui
= require jquery.facebox
= require backbone
= require backbone_patching
= require date_formatter
= require models/profile_models
= require views/profile_views
= require collections/profile_collections
= require logo
###

$ ->
  $('.follow-user').click( ->
    friend = new Friend({id:window.friendId})
    friend.save();
  );
