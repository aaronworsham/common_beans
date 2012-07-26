class window.CompareIndicesView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_indices_template(@model.toJSON());
    $(elem).hide();
    $("#compare-your-portfolios-content #compare-indices-content").append(elem);
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
        categories: [
          "Holding",
          "Dow",
          "Sp500",
          "SpMidcap",
          "NasdaqComposite",
          "AmexComposite",
          "NyseUs100",
          "Russell2000"
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
        color: '#459E00',
        data: [
          10,
          5.6,
          6,
          {color:'#ff0000',y:-3},
          2.5,
          3.4,
          1.9,
          {color:'#ff0000',y:-1.8}
        ]
      }]
    };

#    options.xAxis.categories.push('Holding')
#    console.log(parseInt(@model.attributes['gain_ratio']))
#    options.series[0].data.push(@.redGreen(parseInt(@model.attributes['gain_ratio'])))
#    for k,v of @model.attributes.indices_gain
#      if v != null
#        options.xAxis.categories.push(k)
#        options.series[0].data.push(@.redGreen(v))
#    console.log(options)
#    chart = new Highcharts.Chart(options);
#    $.extend(this, Highcharts.Chart(options))

#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      $.extend(this, Highcharts.Chart(options));
#    );



  redGreen: (data)->
    new_data = {}
    if(data < 0)
      new_data['y'] = data;
      new_data['color'] = '#ff0000';
      return new_data
    else
      return data


class window.CompareValuesView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_values_template(@model.toJSON());
    $(elem).hide();
    $("#compare-your-portfolios-content #compare-values-content").append(elem);
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
#    chart = new Highcharts.Chart(options);


#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#    );


class window.CompareFriendsView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_friends_template(@model.toJSON());
    $(elem).hide();
    $("#compare-your-portfolios-content #compare-friends-content").append(elem);
    $(elem).fadeIn("slow");


    options = {
      chart: {
        renderTo: ("compare-friends-portfolio-" + @model.id),
        type: 'column'
      },
      title: {
        text: 'Compare Friends'
      },
      xAxis: {
        categories: ['D5','D30', 'D60', 'D90', 'D180', 'Y1']
      },
      yAxis: {
        min: 0,
        title: {
          text: 'Compare Friends on CB'
        },
        stackLabels: {
          enabled: true,
          style: {
            fontWeight: 'bold',
            color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
          }
        }
      },
      legend: {
        align: 'right',
        x: -100,
        verticalAlign: 'top',
        y: 20,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
        borderColor: '#CCC',
        borderWidth: 1,
        shadow: false
      },

      plotOptions: {
        column: {
          stacking: 'normal',
          dataLabels: {
            enabled: true,
            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
          }
        }
      },
      series: [
        {
          name: 'Above',
          data: [20, 80, 70, 60, 30, 50]
        }, {
          name: 'Below',
          data: [80, 20, 30, 40, 70, 50]
        }
      ]
    };


#    options.xAxis.categories.push('start')
#    options.series[0].data.push(@model.attributes['starting_value'])
#    for k,v of @model.attributes.past_values
#      options.xAxis.categories.push(k)
#      options.series[0].data.push(v)
#    options.xAxis.categories.push('current')
#    options.series[0].data.push(@model.attributes['current_value'])
#    chart = new Highcharts.Chart(options);


#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#


class window.CompareOthersView extends Backbone.View

  tagName: "li"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = ich.compare_others_template(@model.toJSON());
    $(elem).hide();
    $("#compare-your-portfolios-content #compare-others-content").append(elem);
    $(elem).fadeIn("slow");

    chart = new Highcharts.Chart({
      chart: {
        renderTo: ("compare-others-portfolio-" + @model.id),
        type: 'column'
      },
      title: {
        text: 'Compare Others'
      },
      xAxis: {
        categories: ['D5','D30', 'D60', 'D90', 'D180', 'Y1']
      },
      yAxis: {
        min: 0,
        title: {
          text: 'Compare Friends on CB'
        },
        stackLabels: {
          enabled: true,
          style: {
            fontWeight: 'bold',
            color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
          }
        }
      },
      legend: {
        align: 'right',
        x: -100,
        verticalAlign: 'top',
        y: 20,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
        borderColor: '#CCC',
        borderWidth: 1,
        shadow: false
      },

      plotOptions: {
        column: {
          stacking: 'normal',
          dataLabels: {
            enabled: true,
            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
          }
        }
      },
      series: [
        {
          name: 'Plan Above',
          data: [10, 80, 70, 60, 30, 50],
          stack: 'Plan'
        },{
          name: 'Strat. Above',
          data: [30, 60, 40, 90, 10, 60],
          stack: 'Strategy'
        },{
          name: 'Plan & Strat. Above',
          data: [60, 30, 50, 50, 90, 20],
          stack: 'Plan and Strategy'
        }, {
          name: 'Plan Below',
          data: [90, 20, 30, 40, 70, 50],
          stack: 'Plan'
        }, {
          name: 'Strat. Below',
          data: [70, 40, 60, 10, 90, 40],
          stack: 'Strategy'
        }, {
          name: 'Plan & Strat. Below',
          data: [40, 70, 50, 50, 10, 80],
          stack: 'Plan and Strategy'
        }

      ]
    });

#    options.xAxis.categories.push('start')
#    options.series[0].data.push(@model.attributes['starting_value'])
#    for k,v of @model.attributes.past_values
#      options.xAxis.categories.push(k)
#      options.series[0].data.push(v)
#    options.xAxis.categories.push('current')
#    options.series[0].data.push(@model.attributes['current_value'])
    


#    $.getJSON("/portfolios/1/compare.json", (data)->
#      console.log(data)
#      for k,v of data.indices_gain
#        options.series[0].data.push(v)
#      console.log(options)
#      Highcharts.Chart(options);
#
