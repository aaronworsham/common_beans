class window.CompareIndicesView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_indices_template(@model.toJSON());
    $(elem).hide();
    $("#portfolio-compare").append(elem);
    $(elem).fadeIn("slow");


    window.chart_compare_indices = new Highcharts.Chart({
      chart: {
         renderTo: "compare-indices",
         type: 'bar',
         margin: [ 50, 50, 100, 80]
      },
      title: {
         text: 'Compare Indices to Portfolio since first purchase (' + @model.get('since') + ')'
      },
      xAxis: {
         categories: [
           @model.get('name'),
           'Dow',
           'SP 500',
           'Sp Midcap',
           'Nasdaq Comp',
           'Amex Comp',
           'Nyse Us100',
           'Russell 2000',
           'Sp Comp'
         ],
        labels: {
          align: 'right',
          style: {
            font: 'normal 10px Verdana, sans-serif'
          }
        }
      },
      yAxis: {
         title: {
            text: 'Percent Gains since ' + @model.get('since')
         }
      },
      legend: {
        enabled: false
      },

      series: [{
        color: '#016633',
        data: @markNegative([
                parseInt(@model.get('gain_ratio')),
                parseInt(@model.get('indices_gain')['Dow']),
                parseInt(@model.get('indices_gain')['SpMidcap']),
                parseInt(@model.get('indices_gain')['NasdaqComposite']),
                parseInt(@model.get('indices_gain')['AmexComposite']),
                parseInt(@model.get('indices_gain')['NyseUs100']),
                parseInt(@model.get('indices_gain')['Russell2000']),
                parseInt(@model.get('indices_gain')['SpComposite']),
              ],'#cf0000'),
      }]
    });

  markNegative: (data, color)->
    new_data = []
    for row in data
      if(row < 0)
        new_data.push({y: row, color: color})
      else
        new_data.push(row)
    new_data;



