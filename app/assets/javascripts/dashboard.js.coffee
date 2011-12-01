###
= require application
= require highcharts
= require models/cb_models
= require views/dashboard_views
= require views/application_views
= require collections/application_collections
= require collections/dashboard_collections

###




$ ->

  $('#portfolio-glance').click(->
    window.location = "/trackers"
  );





