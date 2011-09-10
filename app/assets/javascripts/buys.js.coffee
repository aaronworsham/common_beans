# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.Buy extends Backbone.Model
  constructor: (options)->
    @holding = options.holding
    super

  url : "/buys"



class window.BuyView extends Backbone.View









