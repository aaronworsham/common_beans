
class window.Message extends Backbone.Model
  urlRoot : "/messages"


class window.MessageView extends Backbone.View
  tagName: "tr"

  template: JST["dashboard/templates/message"]

  initialize: ->
    @model.view = this

  render: ->
    elem = $(@el).append(@template(@model.toJSON()));
    $(elem).hide();
    $("#tab-everyone table").append(elem);
    $(elem).fadeIn("slow");


class window.MessageCollection extends Backbone.Collection


  model: Message

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new MessageView({model:p});
    view.render();



window.Messages = new MessageCollection
window.Messages.bind('reset', (messages)->
    messages.each( (m)->
      messages.addOneView(m)
    );
);


