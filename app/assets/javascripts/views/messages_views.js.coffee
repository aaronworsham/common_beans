class window.EveryoneMessageView extends Backbone.View
  tagName: "tr"


  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(ich.message_template(@model.toJSON()));
    $(elem).hide();
    $("#tab-everyone table").append(elem);
    $(elem).fadeIn("slow");

class window.FriendMessageView extends Backbone.View
  tagName: "tr"


  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(ich.message_template(@model.toJSON()));
    $(elem).hide();
    $("#tab-friends table").append(elem);
    $(elem).fadeIn("slow");

class window.GroupMessageView extends Backbone.View
  tagName: "tr"


  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(ich.message_template(@model.toJSON()));
    $(elem).hide();
    $("#tab-groups table").append(elem);
    $(elem).fadeIn("slow");

