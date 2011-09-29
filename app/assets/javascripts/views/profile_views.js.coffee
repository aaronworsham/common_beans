class window.ProfileFriendView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.add_friend_template(@model.toJSON()));
    $(elem).hide();
    $('#friend-content').append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );