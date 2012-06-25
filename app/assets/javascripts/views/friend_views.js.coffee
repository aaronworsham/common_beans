class window.FriendPortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = ich.friend_portfolio_template(@model.toJSON());
    $(elem_show).hide();
    $('#show-friends-portfolios-content').append(elem_show);
    $(elem_show).fadeIn("slow");

    options = {
      chart: {
           renderTo: 'friend-portfolio-' + @model.id + '-graph',
           plotBackgroundColor: null,
           plotBorderWidth: null,
           plotShadow: false
      },
      title: {
        text: 'Securities Distribution'
      },

      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            color: '#000000',
            connectorColor: '#000000',
          }
        }
      },
      series: [{
        type: 'pie',
        name: 'Securities Distribution',
        data: [
          ['Apple',   45.0],
          ['Google',       26.0],
          {
            name: 'Microsoft',
            y: 12.0,
            sliced: true,
            selected: true
          },
          ['Yahoo',    8.0],
          ['IBM',     9.0]
        ]
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
