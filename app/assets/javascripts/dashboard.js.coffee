###
= require jquery-1.6.2.min
= require jquery-ui-1.8.16.custom.min
= require jquery.facebox
= require backbone
= require backbone_patching
= require date_formatter
= require currency_formatter
= require ICanHaz
= require models/dashboard_models
= require views/dashboard_views
= require collections/dashboard_collections
= require logo
###



$ ->
  $("#messages").tabs();
  $('#portfolio-glance').click(->
    window.location = "/trackers"
  );


