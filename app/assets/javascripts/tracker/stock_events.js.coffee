# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.StockEvent extends Backbone.Model
  initialize: ->
    @holding = Holdings.get(@get('holding_id'));

  urlRoot : "/events"


class window.StockEventView extends Backbone.View

  tagName: "tr"

  template: JST["tracker/templates/stock_event"]

  initialize: ->
    @model.view = this
    @model.bind('change', @update, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(@template(@model.toJSON()));
    $(elem).hide();
    $(elem).addClass('event-tr');
    $(elem).attr('data-cid', @model.cid);
    $("tr#holding-" + @model.get('holding_id') + '-today').before(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

  update: ->
    $(@el).fadeOut('slow');
    @el = @template(@model.toJSON());
    $(@el).fadeIn("slow");

  


class window.StockEventCollection extends Backbone.Collection
  model: StockEvent
  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (e)->
    view = new StockEventView({model:e});
    view.render();

    


window.StockEvents = new StockEventCollection
window.StockEvents.bind('reset', (events)->
    events.each( (e)->
      events.addOneView(e)
    );
);

