class window.HotlistPortfolioView extends Backbone.View

  tagName: "tr"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = ich.hotlist_portfolio_show_template(@model.formattedData());
    $(elem_show).hide();
    $('#show-your-portfolios-nav table tbody').append(elem_show);
    $(elem_show).fadeIn("slow");

