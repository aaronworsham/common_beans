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
