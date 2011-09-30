###
= require application
= require models/cb_models
= require views/tracker_views
= require collections/tracker_collections

###


$ ->

  $('button.buy_button[rel*=facebox], button.sell_button[rel*=facebox]').live('click', (e)->
    if e.currentTarget.className == 'buy_button'
      url_root = '/buys';
    else
      url_root = '/sells';

    e.stopPropagation();
    $.facebox({div:'#buy-shares'});
    holding_id = $(this).attr('data_holding_id');

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


  $('button#add-portfolio').click((e) ->
    e.stopPropagation();
    $.facebox({div:'#add-portfolio-form'});
    $('#facebox .create_link').click( ->
      portfolio = new PortfolioModel;
      view = new TrackerFaceboxAddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
    );
    $('#facebox form').submit( ->
      portfolio = new PortfolioModel;
      view = new TrackerFaceboxAddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
      return false;
    );
    return false;

  );

  $('button.add-holding').live('click', (e) ->
    e.stopPropagation();
    portfolio = TrackerPortfolios.get($(this).attr('data-portfolio-id'))
    $.facebox({div:'#add-holding-form'});
    $('#facebox .create_link').click( ->
      holding = new TrackerHolding({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );

    $('#facebox form').submit( ->
      holding = new TrackerHolding({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );

  $('.remove-portfolio').live('click',  ->
    p = TrackerPortfolios.get($(this).attr('data-portfolio-id'))
    p.destroy();
  );
  $('.remove-holding').live('click',  ->
    h = TrackerHoldings.get($(this).attr('data-holding-id'))
    h.destroy();
  );
  $('.remove-event').live('click',  ->
    e = TrackerStockEvents.get($(this).attr('data-event-id'))
    holding = e.holding
    e.destroy(
      { success : (model, resp)->
        holding.fetch();
      }
    );
  );












