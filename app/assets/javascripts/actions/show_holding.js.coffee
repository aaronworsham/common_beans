securities = ['stock', 'fund', 'bond', 'etf', 'cd', 'multi']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingView'] extends Backbone.View
      tagName: "tbody"


      initialize: ->
        @model.view = this
        @model.bind('destroy', @remove, this);
        @model.bind('change', @update, this);

      render: ->
        elem = $(@el).append(ich[security+"_holding_template"](@model.formattedData()));
        $(elem).hide();
        $("#portfolio-"+security+"-holding-" + @model.get('portfolio_id')).append(elem);
        $("#portfolio-"+security+"s-" + @model.get('portfolio_id')).fadeIn('fast');
        $(elem).fadeIn("slow");


      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );

      update: ->
        elem = $('#'+security+'-holding-'+@model.id)
        console.log('#'+security+'-holding-'+@model.id)
        $(elem).html(ich["update_"+security+"_holding_template"](@model.formattedData()));
        $(elem).find('td').effect("highlight", {}, 3000);
        @model.chart().view.render()



