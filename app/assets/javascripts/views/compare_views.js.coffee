class window.CompareIndicesView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_indices_template(@model.toJSON());
    $(elem).hide();
    $("#portfolio-compare #compare-indices").append(elem);
    $(elem).fadeIn("slow");


    options = {
      chart: {
         renderTo: ("compare-indices-portfolio-" + @model.id),
         type: 'bar',
         margin: [ 50, 50, 100, 80]
      },
      title: {
         text: 'Compare Indices to Portfolio since first purchase (' + @model.get('since') + ')'
      },
      xAxis: {
         categories: [],
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
        data: []
      }]
    };

#    options.xAxis.categories.push('Holding')
#    options.series[0].data.push(@model.attributes['gain_ratio'])
#    for k,v of @model.attributes.indices_gain
#      options.xAxis.categories.push(k)
#      options.series[0].data.push(v)
#    Highcharts.Chart(options);

#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#    );



  markNegative: (data, color)->
    new_data = []
    for row in data
      if(row < 0)
        new_data.push({y: row, color: color})
      else
        new_data.push(row)
    new_data;



class window.CompareValuesView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_values_template(@model.toJSON());
    $(elem).hide();
    $("#portfolio-compare #compare-values").append(elem);
    $(elem).fadeIn("slow");


    options = {
      chart: {
         renderTo: ("compare-values-portfolio-" + @model.id),
         type: 'line',
         margin: [ 50, 50, 100, 80]
      },
      title: {
         text: 'Values for Model'
      },
      xAxis: {
         categories: [],
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
        data: []
      }]
    };

#    options.xAxis.categories.push('start')
#    options.series[0].data.push(@model.attributes['starting_value'])
#    for k,v of @model.attributes.past_values
#      options.xAxis.categories.push(k)
#      options.series[0].data.push(v)
#    options.xAxis.categories.push('current')
#    options.series[0].data.push(@model.attributes['current_value'])
#    Highcharts.Chart(options);


#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#    );
