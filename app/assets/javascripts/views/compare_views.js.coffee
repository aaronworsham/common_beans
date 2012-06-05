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
        color: '#459E00',
        data: []
      }]
    };

    options.xAxis.categories.push('Holding')
    options.series[0].data.push(@model.attributes['gain_ratio'])
    for k,v of @model.attributes.indices_gain
      options.xAxis.categories.push(k)
      options.series[0].data.push(v)
    chart = new Highcharts.Chart(options);
#    $.extend(this, Highcharts.Chart(options))

#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      $.extend(this, Highcharts.Chart(options));
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
      },
      title: {
         text: 'Values for Model'
      },
      xAxis: {
        categories: ['start','d5','d30','d90','d180','y1','y2','y3','y4','y5','current'],
      },
      yAxis: {
        title: {
           text: 'Percent Gains since ' + @model.get('since')
        }
        plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
        }]
      },

      series: [{
        color: '#459E00',
        name: 'bob',
        data: [100,100,100,100,500,6000,100,500,600,700,100]
      }]
    };

#    options.xAxis.categories.push('start')
#    options.series[0].data.push(@model.attributes['starting_value'])
#    for k,v of @model.attributes.past_values
#      options.xAxis.categories.push(k)
#      options.series[0].data.push(v)
#    options.xAxis.categories.push('current')
#    options.series[0].data.push(@model.attributes['current_value'])
    chart = new Highcharts.Chart(options);


#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#    );
