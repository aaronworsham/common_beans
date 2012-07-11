class window.FriendPortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = ich.friend_portfolio_template(@model.toJSON());
    $(elem_show).hide();
    events_table = $(elem_show).find("table#friend-events-for-portfolio-"+@model.id+" tbody")
    
    for e in @model.attributes['events']
      do (e) ->
        $(events_table).append(ich.friend_event_template(e))
    
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
        name: 'Holding Percentage',
        data: []
      }]
    };

    for v in @model.attributes.distribution
      options.series[0].data.push([v['holding_name'],v['ratio']])
    chart = new Highcharts.Chart(options);
