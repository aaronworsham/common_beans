securities = ['stock', 'fund', 'etf']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingChartView'] extends Backbone.View
      tagName: "tbody"

      initialize: ->
        @model.view = this
        @model.bind('change', @render, this);

      render: ->
        options = {
          chart: {
             renderTo: (security+"-graph-for-holding-"+@model.id),
             type: 'line',
             width: 350,
             height: 150
          },
          title: {
             text: 'test'
          },
          xAxis: {
             categories: [],
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
            data: []
          }]
        };

        options.xAxis.categories.push('S')
        options.series[0].data.push(parseInt(@model.attributes['starting_investment']))

        events = StockEvents.where({stock_holding_id:@model.id})
        for e in events
          options.xAxis.categories.push('E')
          options.series[0].data.push(parseInt(e.attributes['value_to_date']))
        options.xAxis.categories.push('T')
        options.series[0].data.push(@model.attributes['todays_value'])
        chart = new Highcharts.Chart(options);




