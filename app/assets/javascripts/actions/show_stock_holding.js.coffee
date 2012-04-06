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
