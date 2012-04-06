###
= require application
= require models/cb_models
= require views/messages_views
= require views/hotlist_views
= require collections/messages_collections
= require collections/dashboard_collections
= require collections/hotlist_collections
= require_tree ./actions

###




$ ->

  $( "#nav" ).tabs();
  $('.accordion').accordion();

  $('button.buy_button[rel*=facebox], button.sell_button[rel*=facebox]').live('click', (e)->
    if e.currentTarget.className == 'buy_button'
      url_root = '/buys';
    else
      url_root = '/sells';

    e.stopPropagation();
    $.facebox({div:'#buy-shares'});
    holding_id = $(@).attr('data_holding_id');

    submit_form = ->
      event = new StockEventModel({holding_id:holding_id});
      event.urlRoot = url_root
      view = new TrackerFaceboxEventSharesView({model:event});
      view.submit();
      $(document).trigger('close.facebox')

    $('#facebox .record_link').click( ->
      submit_form();
    );

    $('#facebox form').submit( ->
      submit_form();
    );

    return false;
  );

  $('.holding-header').live('click', ->
    type = $(@).attr('data-holding-type')
    id = $(@).attr('data-stock-holding-id')

    $("#"+type+'-events-for-holding-'+id).slideToggle('slow')
  )








