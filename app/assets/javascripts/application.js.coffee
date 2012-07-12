###
= require jquery
= require jquery-ui
= require jquery.ba-serializeobject
= require jquery.cookie
= require autocomplete-rails
= require jquery.facebox
= require underscore-min
= require backbone-min
= require backbone_extend
= require ICanHaz
= require date_formatter
= require humane
= require humane_extend
###

#class HotList
#  currentId : 0
#  select : (id, title, warmlist, callback) ->
#    @.currentId = id;
#    $(warmlist)
#      .find('#portfolio-show h3')
#        .text(title)
#      .end()
#      .find('.add-holding')
#        .attr('data-portfolio-id', id)
#      .end()
#      .fadeIn('fast');
#    callback.call();
#hotlistMenu = new HotList

window.capitaliseFirstLetter = (string)->
  return string.charAt(0).toUpperCase() + string.slice(1);

$ ->
  $('#main-logo').click( ->
    window.location = "/"
  );

  humane.timeout = 5000
  if ($.cookie('cb_notify'))
    humane.log($.cookie('cb_notify'))
    $.cookie('cb_notify', null)

#Compare Tab
  $('#compare-nav tr.selectable').live("click", ->
    module = $(@).attr('data-module');
    $('#compare-content').hide();
    $('#compare-content .compare-module').hide();
    $('#show-content .show-module').hide();
    $('#share-content .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#compare-content #compare-your-portfolios-content').show();
    $('#compare-content '+module).show();
    $('#compare-content').fadeIn('fast');
  );


#Show Your Portfolio

  $('#show-your-portfolios-nav tr.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    stocks = StockHoldings.where({portfolio_id:parseInt(id)});
    funds = FundHoldings.where({portfolio_id:parseInt(id)});
    etfs = EtfHoldings.where({portfolio_id:parseInt(id)});
    multis = MultiHoldings.where({portfolio_id:parseInt(id)});

    $('#compare-content .compare-module').hide();
    $('#show-content').hide();
    $('#show-content .show-module').hide();
    $('#share-content .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#show-your-portfolios-content').show();
    $('#show-your-portfolios-content #portfolio-content-'+id).show();
    if(stocks.length > 0)
      $('#show-your-portfolios-content #portfolio-stocks-'+id).show();
    if(funds.length > 0)
      $('#show-your-portfolios-content #portfolio-funds-'+id).show();
    if(etfs.length > 0)
      $('#show-your-portfolios-content #portfolio-etfs-'+id).show();
    if(multis.length > 0)
      $('#show-your-portfolios-content #portfolio-multis-'+id).show();



    $('#show-content').fadeIn('slow');
  );


#Show Friend Portfolio

  $('#show-friends-portfolios-nav tr.selectable').live("click", ->
    user_id = $(@).attr('data-user-id');

    $('#compare-content .compare-module').hide();
    $('#show-content').hide();
    $('#show-content .show-module').hide();
    $('#share-content .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#show-friends-portfolios-content').show();
    $('#show-content').fadeIn('slow');
  );

#Show Everyone Events

  $('#show-everyone-events-nav tr.selectable').live("click", ->

    $('#compare-content .compare-module').hide();
    $('#show-content').hide();
    $('#show-content .show-module').hide();
    $('#share-content .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#show-everyone-events-content').show();
    $('#show-content').fadeIn('slow');
  );


#Share Tab
  $('#share-nav tr.selectable').live("click", ->

    $('#compare-content .compare-module').hide();
    $('#show-content .show-module').hide();
    $('#share-content').hide();
    $('#share-content .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#share-content .share-module').show();
    $('#share-content').fadeIn('slow');
  );








