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

class HotList
  currentId : 0
  select : (id, title, warmlist, callback) ->
    @.currentId = id;
    $(warmlist)
      .find('#portfolio-show h3')
        .text(title)
      .end()
      .find('.add-holding')
        .attr('data-portfolio-id', id)
      .end()
      .fadeIn('fast');
    callback.call();
hotlistMenu = new HotList

window.capitaliseFirstLetter = (string)->
  return string.charAt(0).toUpperCase() + string.slice(1);

$ ->
  $('#main-logo').click( ->
    window.location = "/"
  );




  $('#nav #compare tr.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    $('#portfolio-compare').hide();
    $('#portfolio-show').hide();
    $('#portfolio-share .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    $('#portfolio-compare #compare-indices > div').hide()
    $('#portfolio-compare #compare-indices #compare-indices-portfolio-'+id).show();
    $('#portfolio-compare #compare-values > div').hide()
    $('#portfolio-compare #compare-values #compare-values-portfolio-'+id).show();
    $('#portfolio-compare').fadeIn('fast');
  );


  $('#nav #show tr.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    stocks = StockHoldings.where({portfolio_id:parseInt(id)});
    funds = FundHoldings.where({portfolio_id:parseInt(id)});
    etfs = EtfHoldings.where({portfolio_id:parseInt(id)});
    bonds = BondHoldings.where({portfolio_id:parseInt(id)});
    cds = CdHoldings.where({portfolio_id:parseInt(id)});
    multis = MultiHoldings.where({portfolio_id:parseInt(id)});

    $('#portfolio-compare').hide();
    $('#portfolio-show').hide();
    $('#portfolio-share .share-module').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    hotlistMenu.select(id, title, '#warmlist-portfolios', ()->
      $('#portfolio-show .portfolio-content').hide()
      $('#portfolio-show #portfolio-content-'+id).show();
      if(stocks.length > 0)
        $('#portfolio-stocks-'+id).show();
      if(funds.length > 0)
        $('#portfolio-funds-'+id).show();
      if(bonds.length > 0)
        $('#portfolio-bonds-'+id).show();
      if(etfs.length > 0)
        $('#portfolio-etfs-'+id).show();
      if(cds.length > 0)
        $('#portfolio-cds-'+id).show();
      if(multis.length > 0)
        $('#portfolio-multis-'+id).show();


    );
    $('#portfolio-show').fadeIn('fast');
  );


  $('#nav #compare tr.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');

    $('#portfolio-compare').hide();
    $('#portfolio-show').hide();
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');

    $('#portfolio-compare').fadeIn('fast');
  );


  $('#nav #share tr.selectable').live("click", ->
    $('#portfolio-compare').hide();
    $('#portfolio-show').hide();
    $('#portfolio-share .share-module').fadeIn('slow');

  );







