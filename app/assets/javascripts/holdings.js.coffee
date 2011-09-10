# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
=require buys
=require sells
###

class window.Holding extends Backbone.Model
  urlRoot : "/holdings"




class window.HoldingView extends Backbone.View

  tagName: "tbody"

  template: JST["templates/holding"]

  initialize: ->
    @model.view = this

  render: ->
    $("#profile-holding-" + @model.get('profile_id')).append($(@el).append(@template(@model.toJSON())));



class window.HoldingCollection extends Backbone.Collection
  constructor: ->
    @url = "/holdings"
    @model = Holding

window.Holdings = new HoldingCollection
