(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.Portfolio = (function() {
    __extends(Portfolio, Backbone.Model);
    function Portfolio() {
      Portfolio.__super__.constructor.apply(this, arguments);
    }
    Portfolio.prototype.urlRoot = "/portfolios";
    return Portfolio;
  })();
  window.PortfolioView = (function() {
    __extends(PortfolioView, Backbone.View);
    function PortfolioView() {
      PortfolioView.__super__.constructor.apply(this, arguments);
    }
    PortfolioView.prototype.tagName = "div";
    PortfolioView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.render, this);
      return this.model.bind('destroy', this.remove, this);
    };
    PortfolioView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.portfolio_template(this.model.toJSON()));
      $(elem).hide();
      $('#portfolio-glance').append(elem);
      return $(elem).fadeIn("slow");
    };
    PortfolioView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return PortfolioView;
  })();
  window.PortfolioCollection = (function() {
    __extends(PortfolioCollection, Backbone.Collection);
    function PortfolioCollection() {
      PortfolioCollection.__super__.constructor.apply(this, arguments);
    }
    PortfolioCollection.prototype.model = Portfolio;
    PortfolioCollection.prototype.initialize = function() {
      return this.bind('add', this.addOneView, this);
    };
    PortfolioCollection.prototype.addOneView = function(p) {
      var view;
      view = new PortfolioView({
        model: p
      });
      return view.render();
    };
    return PortfolioCollection;
  })();
  window.Portfolios = new PortfolioCollection;
  window.Portfolios.bind('reset', function(portfolios) {
    return portfolios.each(function(p) {
      return portfolios.addOneView(p);
    });
  });
}).call(this);
