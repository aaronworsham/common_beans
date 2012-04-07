class window.BondHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.bond_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-bond-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.CdHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.cd_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-cd-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.EtfHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.etf_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-etf-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.FundHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.fund_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-fund-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
  update: ->
    $(@el).html(ich.fund_holding_template(@model.toJSON()));

class window.MultiHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.multi_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-multi-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.StockHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.stock_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-stock-holding-" + @model.get('portfolio_id')).append(elem);
    $("#portfolio-stocks-" + @model.get('portfolio_id')).show();
    $(elem).fadeIn("slow");

  remove: ->

    $(@el).fadeOut("slow", ->
      $(this).remove();
    );






  update: ->
    $(@el).html(ich.stock_holding_template(@model.toJSON()));
