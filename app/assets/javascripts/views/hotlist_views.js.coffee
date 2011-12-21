class window.HotlistPortfolioView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.hotlist_portfolio_template(@model.toJSON());
    $(elem).hide();
    $('#portfolios-hotlist').append(elem);
    $(elem).fadeIn("slow");