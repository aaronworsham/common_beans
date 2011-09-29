(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.HoldingModel = (function() {
    __extends(HoldingModel, Backbone.Model);
    function HoldingModel() {
      HoldingModel.__super__.constructor.apply(this, arguments);
    }
    HoldingModel.prototype.urlRoot = "/holdings";
    return HoldingModel;
  })();
  window.PortfolioModel = (function() {
    __extends(PortfolioModel, Backbone.Model);
    function PortfolioModel() {
      PortfolioModel.__super__.constructor.apply(this, arguments);
    }
    PortfolioModel.prototype.urlRoot = "/portfolios";
    return PortfolioModel;
  })();
  window.MessageModel = (function() {
    __extends(MessageModel, Backbone.Model);
    function MessageModel() {
      MessageModel.__super__.constructor.apply(this, arguments);
    }
    MessageModel.prototype.urlRoot = "/messages";
    return MessageModel;
  })();
  window.FriendModel = (function() {
    __extends(FriendModel, Backbone.Model);
    function FriendModel() {
      FriendModel.__super__.constructor.apply(this, arguments);
    }
    FriendModel.prototype.urlRoot = "/friends";
    return FriendModel;
  })();
  window.StockEventModel = (function() {
    __extends(StockEventModel, Backbone.Model);
    function StockEventModel() {
      StockEventModel.__super__.constructor.apply(this, arguments);
    }
    StockEventModel.prototype.urlRoot = "/events";
    return StockEventModel;
  })();
}).call(this);
