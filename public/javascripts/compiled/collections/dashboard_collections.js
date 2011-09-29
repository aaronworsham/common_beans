(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.DashboardMessageCollection = (function() {
    __extends(DashboardMessageCollection, Backbone.Collection);
    function DashboardMessageCollection() {
      DashboardMessageCollection.__super__.constructor.apply(this, arguments);
    }
    DashboardMessageCollection.prototype.model = MessageModel;
    DashboardMessageCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    DashboardMessageCollection.prototype.addOneView = function(p) {
      var view;
      view = new DashboardMessageView({
        model: p
      });
      return view.render();
    };
    return DashboardMessageCollection;
  })();
  window.Messages = new DashboardMessageCollection;
  window.Messages.bind('reset', function(messages) {
    return messages.each(function(m) {
      return messages.addOneView(m);
    });
  });
  window.PortfolioCollection = (function() {
    __extends(PortfolioCollection, Backbone.Collection);
    function PortfolioCollection() {
      PortfolioCollection.__super__.constructor.apply(this, arguments);
    }
    PortfolioCollection.prototype.model = PortfolioModel;
    PortfolioCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    PortfolioCollection.prototype.addOneView = function(p) {
      var view;
      view = new DashboardPortfolioView({
        model: p
      });
      return view.render();
    };
    return PortfolioCollection;
  })();
  window.DashboardPortfolios = new PortfolioCollection;
  window.DashboardPortfolios.bind('reset', function(portfolios) {
    return portfolios.each(function(p) {
      return portfolios.addOneView(p);
    });
  });
  window.DashboardHoldingCollection = (function() {
    __extends(DashboardHoldingCollection, Backbone.Collection);
    function DashboardHoldingCollection() {
      DashboardHoldingCollection.__super__.constructor.apply(this, arguments);
    }
    DashboardHoldingCollection.prototype.model = HoldingModel;
    DashboardHoldingCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    DashboardHoldingCollection.prototype.addOneView = function(h) {
      var view, view_today;
      view = new DashboardHoldingView({
        model: h
      });
      view_today = new DashboardHoldingTodayView({
        model: h
      });
      view.render();
      return view_today.render();
    };
    return DashboardHoldingCollection;
  })();
  window.DashboardHoldings = new DashboardHoldingCollection;
  window.DashboardHoldings.bind('reset', function(holdings) {
    return holdings.each(function(h) {
      return holdings.addOneView(h);
    });
  });
}).call(this);
