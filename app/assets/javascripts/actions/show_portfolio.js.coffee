class window.PortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.portfolio_template(@model.formattedData()));
    $(elem).hide();
    $('#show-content #show-your-portfolios-content').append(elem);
    $(elem).fadeIn("slow");

    options = {
      chart: {
           renderTo: 'portfolio-content-' + @model.id + '-dist-graph',
           plotBackgroundColor: null,
           plotBorderWidth: null,
           plotShadow: false,
           width:400,
           height:400,
           style: {
            float: 'right'
           }
      },
      title: {
        text: 'Securities Distribution'
      },

      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: false
          },
          showInLegend: false
        }
      },
      series: [{
        type: 'pie',
        name: 'Holding Percentage',
        data: []
      }]
    };

    for v in @model.attributes.distribution
      options.series[0].data.push([v['holding_name'],v['ratio']])
    chart = new Highcharts.Chart(options);





  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


#class window.PortfolioStockView extends Backbone.View
#
#  tagName: "div"
#
#  initialize: ->
#    @model.view = this
#    @model.bind('change', @render, this);
#    @model.bind('destroy', @remove, this);
#
#  render: ->
#    elem = $(@el).append(ich.portfolio_stocks_template(@model.toJSON()));
#    $(elem).hide();
#    $('#portfolio-show #portfolio-stocks ').append(elem);
#    $(elem).fadeIn("slow");
#
#  remove: ->
#    $(@el).fadeOut("slow", ->
#      $(this).remove();
#    );