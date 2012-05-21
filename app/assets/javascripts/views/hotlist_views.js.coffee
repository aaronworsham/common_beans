class window.HotlistPortfolioView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = ich.hotlist_portfolio_show_template(@model.toJSON());
    elem_compare = ich.hotlist_portfolio_compare_template(@model.toJSON());
    $(elem_show).hide();
    $(elem_compare).hide();
    $('#nav #show').append(elem_show);
    $('#nav #compare').append(elem_compare);
    $(elem_show).fadeIn("slow");
    $(elem_compare).fadeIn("slow");

