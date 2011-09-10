# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.StockEvent extends Backbone.Model
  urlRoot : "/events"


class window.StockEventView extends Backbone.View

  tagName: "tr"

  template: JST["templates/stock_event"]

  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(@template(@model.toJSON()));
    $(elem).addClass('event-tr');
    $(elem).attr('data-cid', @model.cid);
    $("tr#holding-id-" + @model.get('holding_id')).parent().append(elem);

  remove: ->
    $('tr[data-cid=' + @model.cid).remove();




class window.StockEventCollection extends Backbone.Collection
  constructor: ->
    @url = "/events"
    @model = StockEvent

window.StockEvents = new StockEventCollection
