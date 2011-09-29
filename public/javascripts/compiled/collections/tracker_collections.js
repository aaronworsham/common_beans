(function() {
  /*
  Tracker Collections
  */
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.TrackerHoldingCollection = (function() {
    __extends(TrackerHoldingCollection, Backbone.Collection);
    function TrackerHoldingCollection() {
      TrackerHoldingCollection.__super__.constructor.apply(this, arguments);
    }
    TrackerHoldingCollection.prototype.model = HoldingModel;
    TrackerHoldingCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    TrackerHoldingCollection.prototype.addOneView = function(h) {
      var view, view_today;
      view = new TrackerHoldingView({
        model: h
      });
      view_today = new TrackerHoldingTodayView({
        model: h
      });
      view.render();
      return view_today.render();
    };
    return TrackerHoldingCollection;
  })();
  window.TrackerHoldings = new TrackerHoldingCollection;
  window.TrackerHoldings.bind('reset', function(holdings) {
    return holdings.each(function(h) {
      return holdings.addOneView(h);
    });
  });
  window.TrackerPortfolioCollection = (function() {
    __extends(TrackerPortfolioCollection, Backbone.Collection);
    function TrackerPortfolioCollection() {
      TrackerPortfolioCollection.__super__.constructor.apply(this, arguments);
    }
    TrackerPortfolioCollection.prototype.model = PortfolioModel;
    TrackerPortfolioCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    TrackerPortfolioCollection.prototype.addOneView = function(p) {
      var view;
      view = new TrackerPortfolioView({
        model: p
      });
      return view.render();
    };
    return TrackerPortfolioCollection;
  })();
  window.TrackerPortfolios = new TrackerPortfolioCollection;
  window.TrackerPortfolios.bind('reset', function(portfolios) {
    return portfolios.each(function(p) {
      return portfolios.addOneView(p);
    });
  });
  window.TrackerStockEventCollection = (function() {
    __extends(TrackerStockEventCollection, Backbone.Collection);
    function TrackerStockEventCollection() {
      TrackerStockEventCollection.__super__.constructor.apply(this, arguments);
    }
    TrackerStockEventCollection.prototype.model = StockEventModel;
    TrackerStockEventCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    TrackerStockEventCollection.prototype.addOneView = function(e) {
      var view;
      view = new TrackerStockEventView({
        model: e
      });
      return view.render();
    };
    return TrackerStockEventCollection;
  })();
  window.TrackerStockEvents = new TrackerStockEventCollection;
  window.TrackerStockEvents.bind('reset', function(events) {
    return events.each(function(e) {
      return events.addOneView(e);
    });
  });
}).call(this);
