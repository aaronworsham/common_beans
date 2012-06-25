###
= require jquery
= require jquery-ui
= require jquery.ba-serializeobject
= require autocomplete-rails
= require jquery.facebox
= require underscore-min
= require backbone-min
= require ICanHaz
= require date_formatter
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


  $('#show-your-portfolios-nav tr.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    stocks = StockHoldings.where({portfolio_id:parseInt(id)});
    funds = FundHoldings.where({portfolio_id:parseInt(id)});
    etfs = EtfHoldings.where({portfolio_id:parseInt(id)});
    bonds = BondHoldings.where({portfolio_id:parseInt(id)});
    cds = CdHoldings.where({portfolio_id:parseInt(id)});
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
    if(bonds.length > 0)
      $('#show-your-portfolios-content #portfolio-bonds-'+id).show();
    if(etfs.length > 0)
      $('#show-your-portfolios-content #portfolio-etfs-'+id).show();
    if(cds.length > 0)
      $('#show-your-portfolios-content #portfolio-cds-'+id).show();
    if(multis.length > 0)
      $('#show-your-portfolios-content #portfolio-multis-'+id).show();



    $('#show-content').fadeIn('fast');
  );

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
    $('#show-content').fadeIn('fast');
  );




  $('#nav #share tr.selectable').live("click", ->
    $('#portfolio-compare').hide();
    $('#portfolio-show').hide();
    $('#portfolio-share .share-module').fadeIn('slow');

  );







