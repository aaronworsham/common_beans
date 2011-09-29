(function() {
  /*
  Tracker Views
  */
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  window.TrackerPortfolioView = (function() {
    __extends(TrackerPortfolioView, Backbone.View);
    function TrackerPortfolioView() {
      TrackerPortfolioView.__super__.constructor.apply(this, arguments);
    }
    TrackerPortfolioView.prototype.tagName = "div";
    TrackerPortfolioView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.render, this);
      return this.model.bind('destroy', this.remove, this);
    };
    TrackerPortfolioView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.portfolio_template(this.model.toJSON()));
      $(elem).hide();
      $('#portfolio-content').append(elem);
      return $(elem).fadeIn("slow");
    };
    TrackerPortfolioView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return TrackerPortfolioView;
  })();
  window.TrackerHoldingView = (function() {
    __extends(TrackerHoldingView, Backbone.View);
    function TrackerHoldingView() {
      TrackerHoldingView.__super__.constructor.apply(this, arguments);
    }
    TrackerHoldingView.prototype.tagName = "tbody";
    TrackerHoldingView.prototype.initialize = function() {
      this.model.view = this;
      return this.model.bind('destroy', this.remove, this);
    };
    TrackerHoldingView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.holding_template(this.model.toJSON()));
      $(elem).hide();
      $("#portfolio-holding-" + this.model.get('portfolio_id')).append(elem);
      return $(elem).fadeIn("slow");
    };
    TrackerHoldingView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return TrackerHoldingView;
  })();
  window.TrackerHoldingTodayView = (function() {
    __extends(TrackerHoldingTodayView, Backbone.View);
    function TrackerHoldingTodayView() {
      TrackerHoldingTodayView.__super__.constructor.apply(this, arguments);
    }
    TrackerHoldingTodayView.prototype.initialize = function() {
      this.model.today_view = this;
      this.model.bind('change', this.update, this);
      return this.model.bind('destroy', this.remove, this);
    };
    TrackerHoldingTodayView.prototype.render = function() {
      var elem;
      this.el = $(ich.holding_today_template(this.model.toJSON()));
      elem = this.el;
      $(elem).hide();
      $("#portfolio-holding-" + this.model.get('portfolio_id') + ' tbody').append(elem);
      return $(elem).fadeIn("slow");
    };
    TrackerHoldingTodayView.prototype.update = function() {
      $(this.el).fadeOut('slow');
      $(this.el).html($(ich.holding_today_update_template(this.model.toJSON())));
      return $(this.el).fadeIn("slow");
    };
    TrackerHoldingTodayView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    return TrackerHoldingTodayView;
  })();
  window.TrackerStockEventView = (function() {
    __extends(TrackerStockEventView, Backbone.View);
    function TrackerStockEventView() {
      TrackerStockEventView.__super__.constructor.apply(this, arguments);
    }
    TrackerStockEventView.prototype.tagName = "tr";
    TrackerStockEventView.prototype.initialize = function() {
      this.model.view = this;
      this.model.bind('change', this.update, this);
      return this.model.bind('destroy', this.remove, this);
    };
    TrackerStockEventView.prototype.render = function() {
      var elem;
      elem = $(this.el).append(ich.stock_event_template(this.model.toJSON()));
      $(elem).hide();
      $(elem).addClass('event-tr');
      $(elem).attr('data-cid', this.model.cid);
      $("tr#holding-" + this.model.get('holding_id') + '-today').before(elem);
      return $(elem).fadeIn("slow");
    };
    TrackerStockEventView.prototype.remove = function() {
      return $(this.el).fadeOut("slow", function() {
        return $(this).remove();
      });
    };
    TrackerStockEventView.prototype.update = function() {
      $(this.el).fadeOut('slow');
      this.el = this.template(this.model.toJSON());
      return $(this.el).fadeIn("slow");
    };
    return TrackerStockEventView;
  })();
  window.TrackerFaceboxEventSharesView = (function() {
    __extends(TrackerFaceboxEventSharesView, Backbone.View);
    function TrackerFaceboxEventSharesView() {
      this.serialize = __bind(this.serialize, this);
      this.submit = __bind(this.submit, this);
      TrackerFaceboxEventSharesView.__super__.constructor.apply(this, arguments);
    }
    TrackerFaceboxEventSharesView.prototype.el = '#facebox';
    TrackerFaceboxEventSharesView.prototype.submit = function() {
      return this.model.save(this.serialize(), {
        success: function(model, resp) {
          TrackerStockEvents.add(model);
          return model.holding.fetch();
        }
      });
    };
    TrackerFaceboxEventSharesView.prototype.serialize = function() {
      return {
        event: {
          shares: this.$("#event_shares").val(),
          price: this.$("#event_price").val(),
          'date_of_event(1i)': this.$("#event_date_of_event_1i").val(),
          'date_of_event(2i)': this.$("#event_date_of_event_2i").val(),
          'date_of_event(3i)': this.$("#event_date_of_event_3i").val(),
          'date_of_event(4i)': this.$("#event_date_of_event_4i").val(),
          'date_of_event(5i)': this.$("#event_date_of_event_5i").val(),
          ticker_id: this.model.holding.get('ticker_id'),
          holding_id: this.model.holding.id,
          type: this.model.get('type')
        }
      };
    };
    return TrackerFaceboxEventSharesView;
  })();
  window.TrackerFaceboxAddPortfolioView = (function() {
    __extends(TrackerFaceboxAddPortfolioView, Backbone.View);
    function TrackerFaceboxAddPortfolioView() {
      this.serialize = __bind(this.serialize, this);
      this.submit = __bind(this.submit, this);
      TrackerFaceboxAddPortfolioView.__super__.constructor.apply(this, arguments);
    }
    TrackerFaceboxAddPortfolioView.prototype.el = '#facebox';
    TrackerFaceboxAddPortfolioView.prototype.submit = function() {
      return this.model.save(this.serialize(), {
        success: function(model, resp) {
          return TrackerPortfolios.add(model);
        }
      });
    };
    TrackerFaceboxAddPortfolioView.prototype.serialize = function() {
      return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        portfolio: {
          name: this.$("#portfolio_name").val()
        }
      };
    };
    return TrackerFaceboxAddPortfolioView;
  })();
  window.TrackerFaceboxAddHoldingView = (function() {
    __extends(TrackerFaceboxAddHoldingView, Backbone.View);
    function TrackerFaceboxAddHoldingView() {
      this.serialize = __bind(this.serialize, this);
      this.submit = __bind(this.submit, this);
      TrackerFaceboxAddHoldingView.__super__.constructor.apply(this, arguments);
    }
    TrackerFaceboxAddHoldingView.prototype.el = '#facebox';
    TrackerFaceboxAddHoldingView.prototype.submit = function() {
      return this.model.save(this.serialize(), {
        success: function(model, resp) {
          return TrackerHoldings.add(model);
        }
      });
    };
    TrackerFaceboxAddHoldingView.prototype.serialize = function() {
      return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        holding: {
          ticker_id: this.$("#holding_ticker_id").val(),
          starting_shares: this.$("#holding_starting_shares").val(),
          starting_price: this.$("#holding_starting_price").val(),
          'date_of_purchase(1i)': this.$("#holding_date_of_purchase_1i").val(),
          'date_of_purchase(2i)': this.$("#holding_date_of_purchase_2i").val(),
          'date_of_purchase(3i)': this.$("#holding_date_of_purchase_3i").val(),
          'date_of_purchase(4i)': this.$("#holding_date_of_purchase_4i").val(),
          'date_of_purchase(5i)': this.$("#holding_date_of_purchase_5i").val(),
          portfolio_id: this.model.get('portfolio_id')
        }
      };
    };
    return TrackerFaceboxAddHoldingView;
  })();
}).call(this);
