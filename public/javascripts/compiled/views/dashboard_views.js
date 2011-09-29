(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.DashboardMessageView = (function() {
    __extends(DashboardMessageView, Backbone.View);
    function DashboardMessageView() {
      DashboardMessageView.__super__.constructor.apply(this, arguments);
    }
    DashboardMessageView.prototype.tagName = "tr";
    DashboardMessageView.prototype.initialize = function() {
      return this.model.view = this;
    };
    DashboardMessageView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.message_template(this.model.toJSON()));
      $(elem).hide();
      $("#tab-everyone table").append(elem);
      return $(elem).fadeIn("slow");
    };
    return DashboardMessageView;
  })();
  window.DashboardPortfolioView = (function() {
    __extends(DashboardPortfolioView, Backbone.View);
    function DashboardPortfolioView() {
      DashboardPortfolioView.__super__.constructor.apply(this, arguments);
    }
    DashboardPortfolioView.prototype.tagName = "div";
    DashboardPortfolioView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.render, this);
      return this.model.bind('destroy', this.remove, this);
    };
    DashboardPortfolioView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.portfolio_template(this.model.toJSON()));
      $(elem).hide();
      $('#portfolio-glance').append(elem);
      return $(elem).fadeIn("slow");
    };
    DashboardPortfolioView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return DashboardPortfolioView;
  })();
  window.DashboardHoldingView = (function() {
    __extends(DashboardHoldingView, Backbone.View);
    function DashboardHoldingView() {
      DashboardHoldingView.__super__.constructor.apply(this, arguments);
    }
    DashboardHoldingView.prototype.tagName = "tbody";
    DashboardHoldingView.prototype.initialize = function() {
      this.model.view = this;
      return this.model.bind('destroy', this.remove, this);
    };
    DashboardHoldingView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.holding_today_template(this.model.toJSON()));
      $(elem).hide();
      $("#portfolio-holding-" + this.model.get('portfolio_id')).append(elem);
      return $(elem).fadeIn("slow");
    };
    DashboardHoldingView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return DashboardHoldingView;
  })();
  window.DashbaordHoldingTodayView = (function() {
    __extends(DashbaordHoldingTodayView, Backbone.View);
    function DashbaordHoldingTodayView() {
      DashbaordHoldingTodayView.__super__.constructor.apply(this, arguments);
    }
    DashbaordHoldingTodayView.prototype.initialize = function() {
      this.model.today_view = this;
      this.model.bind('change', this.update, this);
      return this.model.bind('destroy', this.remove, this);
    };
    DashbaordHoldingTodayView.prototype.render = function() {
      var elem;
      this.el = $(ich.holding_today_template(this.model.toJSON()));
      elem = this.el;
      $(elem).hide();
      $("#portfolio-holding-" + this.model.get('portfolio_id') + ' tbody').append(elem);
      return $(elem).fadeIn("slow");
    };
    DashbaordHoldingTodayView.prototype.update = function() {
      $(this.el).fadeOut('slow');
      $(this.el).html($(ich.holding_update_template(this.model.toJSON())));
      return $(this.el).fadeIn("slow");
    };
    DashbaordHoldingTodayView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return DashbaordHoldingTodayView;
  })();
}).call(this);
