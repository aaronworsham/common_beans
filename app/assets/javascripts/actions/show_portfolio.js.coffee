class window.PortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('add', @render, this);
    @model.bind('change', @update, this);
    @model.bind('destroy', @remove, this);

  update: ->
    update = ich.update_portfolio_template(@model.formattedData());
    elem = $('#portfolio-content-'+ @model.id + ' .portfolio-header')
    $(elem).hide();
    $(elem).html(update);
    $(elem).fadeIn("slow", ->
      $(@).effect("highlight", {}, 3000);
    )    
    nav_update = ich.update_hotlist_portfolio_show_template(@model.formattedData());
    elem_show = $('#show-your-portfolios-nav tr[data-id='+@model.id+']')
    $(elem_show).hide();
    $(elem_show).html(nav_update)
    $(elem_show).fadeIn("slow", ->
      $(@).find('td').effect("highlight", {}, 3000);
    );
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
    #chart = new Highcharts.Chart(options);


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
    #chart = new Highcharts.Chart(options);





  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


