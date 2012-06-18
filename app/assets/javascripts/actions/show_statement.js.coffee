
class window['MultiStatementView'] extends Backbone.View
  tagName: "tbody"
  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich["multi_statement_template"](@model.toJSON()));
    $(elem).hide();
    $("#multi-events-for-holding-" + @model.get('multi_holding_id') + " table").append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

  update: ->
    $(@el).html(ich["multi_statement_template"](@model.toJSON()));

class window['MultiAllocationView'] extends Backbone.View

  tagName: "tr"

  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich["multi_allocation_template"](@model.toJSON()));
    $(elem).hide();
    $("#allocations-for-multi-statement-" + @model.get('multi_statement_id') + ' ul' ).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

  update: ->
    $(@el).html(ich["multi_statement_template"](@model.toJSON()));




