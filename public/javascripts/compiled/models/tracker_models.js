(function() {
  /*
  Tracker Models
  */
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.TrackerPortfolio = (function() {
    __extends(TrackerPortfolio, Backbone.Model);
    function TrackerPortfolio() {
      TrackerPortfolio.__super__.constructor.apply(this, arguments);
    }
    TrackerPortfolio.prototype.urlRoot = "/portfolios";
    return TrackerPortfolio;
  })();
  window.TrackerHolding = (function() {
    __extends(TrackerHolding, Backbone.Model);
    function TrackerHolding() {
      TrackerHolding.__super__.constructor.apply(this, arguments);
    }
    TrackerHolding.prototype.urlRoot = "/holdings";
    return TrackerHolding;
  })();
  window.TrackerStockEvent = (function() {
    __extends(TrackerStockEvent, Backbone.Model);
    function TrackerStockEvent() {
      TrackerStockEvent.__super__.constructor.apply(this, arguments);
    }
    TrackerStockEvent.prototype.urlRoot = "/events";
    return TrackerStockEvent;
  })();
}).call(this);
