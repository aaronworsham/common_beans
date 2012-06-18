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
        $("#portfolio-"+security+"s-" + @model.get('portfolio_id')).fadeIn('fast');
        $(elem).fadeIn("slow");
        options = {
          chart: {
             renderTo: (security+"-graph-for-holding-"+@model.id),
             type: 'column',
             width: 350,
             height: 150
          },
          title: {
             text: 'test'
          },
          xAxis: {
             categories: ['a','b','c'],
            labels: {
              style: {
                font: 'normal 10px Verdana, sans-serif'
              }
            }
          },
          yAxis: {
             title: {
                text: 'test'
             }
          },
          legend: {
            enabled: false
          },

          series: [{
            color: '#459E00',
            data: [10,20,30]
          }]
        };


        chart = new Highcharts.Chart(options);

      remove: ->
        $(@el).fadeOut("slow", ->
          $(this).remove();
        );

      update: ->
        $(@el).html(ich[security+"_holding_template"](@model.toJSON()));



