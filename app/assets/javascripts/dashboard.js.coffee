###
= require application
= require highcharts
= require models/cb_models
= require views/dashboard_views
= require collections/dashboard_collections

###




$ ->
  $("#messages").tabs();
  $('#portfolio-glance').click(->
    window.location = "/trackers"
  );





