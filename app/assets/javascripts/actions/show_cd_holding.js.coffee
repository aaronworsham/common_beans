class window.CdHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.cd_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-cd-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

