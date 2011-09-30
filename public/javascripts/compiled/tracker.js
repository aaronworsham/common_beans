(function() {
  /*
  = require application
  = require models/cb_models
  = require views/tracker_views
  = require collections/tracker_collections
  
  */  $(function() {
    $('button.buy_button[rel*=facebox], button.sell_button[rel*=facebox]').live('click', function(e) {
      var holding_id, submit_form, url_root;
      if (e.currentTarget.className === 'buy_button') {
        url_root = '/buys';
      } else {
        url_root = '/sells';
      }
      e.stopPropagation();
      $.facebox({
        div: '#buy-shares'
      });
      holding_id = $(this).attr('data_holding_id');
      submit_form = function() {
        var event, view;
        event = new StockEventModel({
          holding_id: holding_id
        });
        event.urlRoot = url_root;
        view = new TrackerFaceboxEventSharesView({
          model: event
        });
        view.submit();
        return $(document).trigger('close.facebox');
      };
      $('#facebox .record_link').click(function() {
        return submit_form();
      });
      $('#facebox form').submit(function() {
        return submit_form();
      });
      return false;
    });
    $('button#add-portfolio').click(function(e) {
      e.stopPropagation();
      $.facebox({
        div: '#add-portfolio-form'
      });
      $('#facebox .create_link').click(function() {
        var portfolio, view;
        portfolio = new PortfolioModel;
        view = new TrackerFaceboxAddPortfolioView({
          model: portfolio
        });
        view.submit();
        return $(document).trigger('close.facebox');
      });
      $('#facebox form').submit(function() {
        var portfolio, view;
        portfolio = new PortfolioModel;
        view = new TrackerFaceboxAddPortfolioView({
          model: portfolio
        });
        view.submit();
        $(document).trigger('close.facebox');
        return false;
      });
      return false;
    });
    $('button.add-holding').live('click', function(e) {
      var portfolio;
      e.stopPropagation();
      portfolio = TrackerPortfolios.get($(this).attr('data-portfolio-id'));
      $.facebox({
        div: '#add-holding-form'
      });
      $('#facebox .create_link').click(function() {
        var holding, view;
        holding = new TrackerHolding({
          portfolio_id: portfolio.id
        });
        view = new TrackerFaceboxAddHoldingView({
          model: holding
        });
        view.submit();
        return $(document).trigger('close.facebox');
      });
      $('#facebox form').submit(function() {
        var holding, view;
        holding = new TrackerHolding({
          portfolio_id: portfolio.id
        });
        view = new TrackerFaceboxAddHoldingView({
          model: holding
        });
        view.submit();
        return $(document).trigger('close.facebox');
      });
      return false;
    });
    $('.remove-portfolio').live('click', function() {
      var p;
      p = TrackerPortfolios.get($(this).attr('data-portfolio-id'));
      return p.destroy();
    });
    $('.remove-holding').live('click', function() {
      var h;
      h = TrackerHoldings.get($(this).attr('data-holding-id'));
      return h.destroy();
    });
    return $('.remove-event').live('click', function() {
      var e, holding;
      e = TrackerStockEvents.get($(this).attr('data-event-id'));
      holding = e.holding;
      return e.destroy({
        success: function(model, resp) {
          return holding.fetch();
        }
      });
    });
  });
}).call(this);
