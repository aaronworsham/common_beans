# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
=require holdings
###


class window.Profile extends Backbone.Model
  urlRoot : "/profiles"


class window.ProfileView extends Backbone.View

  tagName: "div"

  template: JST["templates/profile"]

  initialize: ->
    @model.view = this
    

  render: ->
    $('#profile-content').append($(@el).append(@template(@model.toJSON())));



class window.ProfileCollection extends Backbone.Collection
  constructor: ->
    @url = "/profiles"
    @model = Profile

window.Profiles = new ProfileCollection




