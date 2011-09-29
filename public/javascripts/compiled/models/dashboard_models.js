(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.DashboardHolding = (function() {
    __extends(DashboardHolding, Backbone.Model);
    function DashboardHolding() {
      DashboardHolding.__super__.constructor.apply(this, arguments);
    }
    DashboardHolding.prototype.initialize = function() {
      return this.portfolio = DashboardPortfolios.get(this.get('portfolio_id'));
    };
    DashboardHolding.prototype.urlRoot = "/holdings";
    return DashboardHolding;
  })();
  window.DashboardPortfolio = (function() {
    __extends(DashboardPortfolio, Backbone.Model);
    function DashboardPortfolio() {
      DashboardPortfolio.__super__.constructor.apply(this, arguments);
    }
    DashboardPortfolio.prototype.urlRoot = "/portfolios";
    return DashboardPortfolio;
  })();
  window.DashbaordMessage = (function() {
    __extends(DashbaordMessage, Backbone.Model);
    function DashbaordMessage() {
      DashbaordMessage.__super__.constructor.apply(this, arguments);
    }
    DashbaordMessage.prototype.urlRoot = "/messages";
    return DashbaordMessage;
  })();
}).call(this);
