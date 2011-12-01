class window.EveryoneMessageCollection extends Backbone.Collection
  model: MessageModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new EveryoneMessageView({model:p});
    view.render();




window.EveryoneMessages = new EveryoneMessageCollection
window.EveryoneMessages.bind('reset', (messages)->
    messages.each( (m)->
      messages.addOneView(m)
    );
);

class window.FriendMessageCollection extends Backbone.Collection
  model: MessageModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new FriendMessageView({model:p});
    view.render();




window.FriendMessages = new FriendMessageCollection
window.FriendMessages.bind('reset', (messages)->
    messages.each( (m)->
      messages.addOneView(m)
    );
);

class window.GroupMessageCollection extends Backbone.Collection
  model: MessageModel

  initialize: ->
    @bind('add', @addOneView, this);

  addOneView: (p)->
    view = new GroupMessageView({model:p});
    view.render();




window.GroupMessages = new GroupMessageCollection
window.GroupMessages.bind('reset', (messages)->
    messages.each( (m)->
      messages.addOneView(m)
    );
);

