class window.PortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.portfolio_template(@model.formattedData()));
    $(elem).hide();
    $('#show-content #show-your-portfolios-content').append(elem);
    $(elem).fadeIn("slow");






  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


#class window.PortfolioStockView extends Backbone.View
#
#  tagName: "div"
#
#  initialize: ->
#    @model.view = this
#    @model.bind('change', @render, this);
#    @model.bind('destroy', @remove, this);
#
#  render: ->
#    elem = $(@el).append(ich.portfolio_stocks_template(@model.toJSON()));
#    $(elem).hide();
#    $('#portfolio-show #portfolio-stocks ').append(elem);
#    $(elem).fadeIn("slow");
#
#  remove: ->
#    $(@el).fadeOut("slow", ->
#      $(this).remove();
#    );