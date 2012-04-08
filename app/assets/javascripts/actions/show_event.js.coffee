securities = ['stock', 'fund', 'etf']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingView'] extends Backbone.View
      tagName: "tbody"




    class window[capSecurity+'BuyView'] extends Backbone.View

      tagName: "li"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);

      render: ->
        elem = $(@el).append(ich[security+'_buy_template'](@model.toJSON()));
        $(elem).hide();
        $("#"+security+"-buys-for-holding-" + @model.get(security+'_holding_id')).append(elem);
        $(elem).fadeIn("slow");

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );
      update: ->
        $(@el).html(ich[security+'_buy_template'](@model.toJSON()));


    class window[capSecurity+'SellView'] extends Backbone.View

      tagName: "li"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);

      render: ->
        elem = $(@el).append(ich[security+'_sell_template'](@model.toJSON()));
        $(elem).hide();
        $("#"+security+"-sells-for-holding-" + @model.get(security+'_holding_id')).append(elem);
        $(elem).fadeIn("slow");

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );
      update: ->
        $(@el).html(ich[security+'_sell_template'](@model.toJSON()));

