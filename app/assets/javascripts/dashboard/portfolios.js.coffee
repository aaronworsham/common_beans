# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.Portfolio extends Backbone.Model
  urlRoot : "/portfolios"


class window.PortfolioView extends Backbone.View

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


class window.PortfolioCollection extends Backbone.Collection
  model: Portfolio

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new PortfolioView({model:p});
    view.render();



window.Portfolios = new PortfolioCollection
window.Portfolios.bind('reset', (portfolios)->
    portfolios.each( (p)->
      portfolios.addOneView(p)
    );
);




