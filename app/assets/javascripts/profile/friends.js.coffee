# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.Friend extends Backbone.Model
  urlRoot : "/friends"


class window.FriendView extends Backbone.View

  tagName: "div"

  template: JST["tracker/templates/add_friend"]

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);
    
  render: ->
    elem = $(@el).append(@template(@model.toJSON()));
    $(elem).hide();
    $('#friend-content').append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.FriendCollection extends Backbone.Collection
  model: Friend

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (f)->
    view = new FriendView({model:f});
    view.render();



window.Friends = new FriendCollection
window.Friends.bind('reset', (friends)->
    friends.each( (f)->
      friends.addOneView(f)
    );
);






