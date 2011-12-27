###
= require application
= require models/cb_models
= require views/dashboard_views
= require views/messages_views
= require views/tracker_views
= require views/hotlist_views
= require collections/messages_collections
= require collections/dashboard_collections
= require collections/hotlist_collections
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

  $('.add-stock').live('click', (e) ->
    portfolio = DashboardPortfolios.get($(this).attr('data-portfolio-id'))
    console.log(portfolio);

    $.facebox({div:'#add-holding-form'});
    $('#facebox .create_link').click( ->
      holding = new HoldingModel({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );

    $('#facebox form').submit( ->
      holding = new HoldingModel({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );

  $('.add-fund').live('click', (e) ->
    portfolio = DashboardPortfolios.get($(this).attr('data-portfolio-id'))
    console.log(portfolio);

    $.facebox({div:'#add-holding-form'});
    $('#facebox .create_link').click( ->
      holding = new HoldingModel({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );

    $('#facebox form').submit( ->
      holding = new HoldingModel({portfolio_id:portfolio.id});
      view = new TrackerFaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );


  $('#portfolios-hotlist li.add_item').click((e) ->
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




