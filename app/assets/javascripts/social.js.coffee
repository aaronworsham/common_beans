###
=require jquery-1.6.2.min
=require jquery-ui-1.8.16.custom.min
= require jquery.facebox
= require backbone
= require backbone_patching
= require date_formatter
= require models/social_models
= require views/social_views
= require collections/social_collections
= require logo
###

$ ->
  $('#friends').tabs();