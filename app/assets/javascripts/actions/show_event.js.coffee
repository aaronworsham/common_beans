securities = ['stock', 'fund', 'etf']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)

    class window[capSecurity+'BuyView'] extends Backbone.View

      tagName: "tr"

    class window[capSecurity+'SellView'] extends Backbone.View

      tagName: "tr"


    class window[capSecurity+'EventView'] extends Backbone.View

      tagName: "tr"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);

      render: ->
        elem = $(@el).append(ich[security+'_event_template'](@model.toJSON()));
        $(elem).hide();
        $("#"+security+"-events-for-holding-" + @model.get(security+'_holding_id') + " tbody").append(elem);
        $(elem).fadeIn("slow");

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );
      update: ->
        $(@el).html(ich[security+'_event_template'](@model.toJSON()));

