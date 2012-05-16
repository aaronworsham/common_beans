securities = ['multi']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'StatementView'] extends Backbone.View
      tagName: "tbody"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);

      render: ->
        elem = $(@el).append(ich[security+"_statement_template"](@model.toJSON()));
        $(elem).hide();
        $("#"+security+"-events-for-holding-" + @model.get('multi_holding_id')).append(elem);
        $(elem).fadeIn("slow");

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );

      update: ->
        $(@el).html(ich[security+"_statement_template"](@model.toJSON()));



