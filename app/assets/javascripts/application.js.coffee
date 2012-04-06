###
= require jquery
= require jquery-ui
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
      .find('h3')
        .text(title)
      .end()
      .find('.add-holding')
        .attr('data-portfolio-id', id)
      .end()
      .fadeIn('fast');
    callback.call();
hotlistMenu = new HotList

$ ->
  $('#main-logo').click( ->
    window.location = "/"
  );




  $('#nav li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    stocks = StockHoldings.where({portfolio_id:parseInt(id)});
    funds = FundHoldings.where({portfolio_id:parseInt(id)});
    etfs = EtfHoldings.where({portfolio_id:parseInt(id)});
    bonds = BondHoldings.where({portfolio_id:parseInt(id)});
    cds = CdHoldings.where({portfolio_id:parseInt(id)});
    multis = MultiHoldings.where({portfolio_id:parseInt(id)});

    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    hotlistMenu.select(id, title, '#warmlist-portfolios', ()->
      $('.portfolio-content').hide()
      $('#portfolio-content-'+id).fadeIn('fast');
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
  );
  $('#groups-hotlist li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    hotlistMenu.select(id, title, '#warmlist-groups')
  );
  $('#friends-hotlist li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    hotlistMenu.select(id, title, '#warmlist-friends')
  );




