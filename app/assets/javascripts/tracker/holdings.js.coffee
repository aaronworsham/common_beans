# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


class window.Holding extends Backbone.Model
  initialize: ->
    @portfolio = Portfolios.get(@get('portfolio_id'));

  urlRoot : "/holdings"




class window.HoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.HoldingTodayView extends Backbone.View


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
    $(@el).html($(ich.holding_today_update_template(@model.toJSON())));
    $(@el).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.HoldingCollection extends Backbone.Collection
  model: Holding 
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (h)->
    view = new HoldingView({model:h});
    view_today = new HoldingTodayView({model:h});
    view.render();
    view_today.render();

    

window.Holdings = new HoldingCollection
window.Holdings.bind('reset', (holdings)->
    holdings.each( (h)->
      holdings.addOneView(h)
    );
);

