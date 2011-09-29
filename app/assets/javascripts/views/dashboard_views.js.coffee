
class window.DashboardMessageView extends Backbone.View
  tagName: "tr"


  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(ich.message_template(@model.toJSON()));
    $(elem).hide();
    $("#tab-everyone table").append(elem);
    $(elem).fadeIn("slow");

class window.DashboardPortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.portfolio_template(@model.toJSON()));
    $(elem).hide();
    $('#portfolio-glance').append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.DashboardHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.holding_today_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.DashbaordHoldingTodayView extends Backbone.View


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
    $(@el).html($(ich.holding_update_template(@model.toJSON())));
    $(@el).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );