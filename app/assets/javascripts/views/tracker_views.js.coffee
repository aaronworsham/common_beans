###
Tracker Views
###

class window.TrackerPortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.portfolio_template(@model.toJSON()));
    $(elem).hide();
    $('#portfolio-content').append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.TrackerHoldingView extends Backbone.View

  tagName: "tbody"

  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.TrackerHoldingTodayView extends Backbone.View


  initialize: ->
    @model.today_view = this
    @model.bind('change', @update, this);
    @model.bind('destroy', @remove, this);

  render: ->
    @el = $(ich.holding_today_template(@model.toJSON()));
    elem = @el;
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id') + ' tbody').append(elem);
    $(elem).fadeIn("slow");

  update: ->
    $(@el).fadeOut('slow');
    $(@el).html($(ich.holding_today_update_template(@model.toJSON())));
    $(@el).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.TrackerStockEventView extends Backbone.View

  tagName: "tr"


  initialize: ->
    @model.view = this
    @model.bind('change', @update, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.stock_event_template(@model.toJSON()));
    $(elem).hide();
    $(elem).addClass('event-tr');
    $(elem).attr('data-cid', @model.cid);
    $("tr#holding-" + @model.get('holding_id') + '-today').before(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

  update: ->
    $(@el).fadeOut('slow');
    @el = @template(@model.toJSON());
    $(@el).fadeIn("slow");

class window.TrackerFaceboxEventSharesView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          TrackerStockEvents.add(model);
          model.holding.fetch();
        }
    );

  serialize: =>
    return {
        event: {
          shares: this.$("#event_shares").val(),
          price: this.$("#event_price").val(),
          'date_of_event(1i)': this.$("#event_date_of_event_1i").val(),
          'date_of_event(2i)': this.$("#event_date_of_event_2i").val(),
          'date_of_event(3i)': this.$("#event_date_of_event_3i").val(),
          'date_of_event(4i)': this.$("#event_date_of_event_4i").val(),
          'date_of_event(5i)': this.$("#event_date_of_event_5i").val(),
          ticker_id: @model.holding.get('ticker_id'),
          holding_id: @model.holding.id,
          type: @model.get('type')
        }
      }


class window.TrackerFaceboxAddPortfolioView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          TrackerPortfolios.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        portfolio: {
          name: this.$("#portfolio_name").val(),
        }
      }

class window.TrackerFaceboxAddHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          TrackerHoldings.add(model)
        }
    );

  serialize: =>
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
          portfolio_id: @model.get('portfolio_id')
        }
      }
