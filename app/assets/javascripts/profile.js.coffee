###
= require application
= require models/cb_models
= require views/profile_views
= require collections/profile_collections

###

$ ->

  $('.trust_user').click( (e)->
    e.stopPropagation();
    user_id = $(this).attr('data_user_id');
    level = $(this).attr('data_level');
    trust = new TrustModel({user_id:user_id, level:level});
    view = new ProfileTrustView({model:trust});
    view.submit();
    return false;
  );
  $('.distrust').click( (e)->
    e.stopPropagation();
    user_id = $(this).attr('data_user_id');
    trust = new TrustModel({user_id:user_id, level:level});
    view = new ProfileTrustView({model:trust});
    view.submit();
    return false;
  );