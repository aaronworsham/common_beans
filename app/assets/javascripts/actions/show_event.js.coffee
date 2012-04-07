class window.FundBuyView extends Backbone.View

  tagName: "li"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.fund_buy_template(@model.toJSON()));
    $(elem).hide();
    $("#fund-buys-for-holding-" + @model.get('fund_holding_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
  update: ->
    $(@el).html(ich.fund_holding_template(@model.toJSON()));


class window.FundSellView extends Backbone.View

  tagName: "li"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.fund_sell_template(@model.toJSON()));
    $(elem).hide();
    $("#fund-sells-for-holding-" + @model.get('fund_holding_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
  update: ->
    $(@el).html(ich.fund_holding_template(@model.toJSON()));


class window.StockBuyView extends Backbone.View

  tagName: "li"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.stock_buy_template(@model.toJSON()));
    $(elem).hide();
    $("#stock-buys-for-holding-" + @model.get('stock_holding_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
  update: ->
    $(@el).html(ich.stock_holding_template(@model.toJSON()));


class window.StockSellView extends Backbone.View

  tagName: "li"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.stock_sell_template(@model.toJSON()));
    $(elem).hide();
    $("#stock-sells-for-holding-" + @model.get('stock_holding_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
  update: ->
    $(@el).html(ich.stock_holding_template(@model.toJSON()));
