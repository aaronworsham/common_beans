securities = ['stock', 'fund', 'bond', 'etf', 'cd', 'multi']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingView'] extends Backbone.View
      tagName: "tbody"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);

      render: ->
        elem = $(@el).append(ich[security+"_holding_template"](@model.toJSON()));
        $(elem).hide();
        $("#portfolio-"+security+"-holding-" + @model.get('portfolio_id')).append(elem);
        $(elem).fadeIn("slow");

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );

      update: ->
        $(@el).html(ich[security+"_holding_template"](@model.toJSON()));



