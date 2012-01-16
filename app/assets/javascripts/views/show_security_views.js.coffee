

class window.PortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.dashboard_portfolio_template(@model.toJSON()));
    $(elem).hide();
    $('#portfolio-glance').append(elem);
    $(elem).fadeIn("slow");



#    window.chart_gainloss = new Highcharts.Chart({
#      chart: {
#         renderTo: "chart_gainloss_"+@model.id,
#         type: 'column'
#      },
#      title: {
#         text: 'Portfolio Value Gains/Losses'
#      },
#      xAxis: {
#         opposite: true,
#         categories: ['1 Day', '1 Week', '1 Month', '3 Month', '6 Month', '9 Month', '1 Year', '2 Year','3 Year']
#      },
#      yAxis: {
#         title: {
#            text: 'Value Gains/Losses'
#         }
#      },
#      series: [{
#        name: 'Value Delta From Today',
#        data: [
#                parseInt(@model.get('day_value_gain_to_today')),
#                parseInt(@model.get('week_value_gain_to_today')),
#                parseInt(@model.get('one_month_value_gain_to_today')),
#                parseInt(@model.get('three_month_value_gain_to_today')),
#                parseInt(@model.get('six_month_value_gain_to_today')),
#                parseInt(@model.get('nine_month_value_gain_to_today')),
#                parseInt(@model.get('one_year_value_gain_to_today')),
#                parseInt(@model.get('two_year_value_gain_to_today')),
#                parseInt(@model.get('three_year_value_gain_to_today'))
#              ],
#        type: 'column'}
#        {
#        name: 'Trend From Today',
#        data: [
#                parseInt(@model.get('day_value_gain_to_today')),
#                parseInt(@model.get('week_value_gain_to_today')),
#                parseInt(@model.get('one_month_value_gain_to_today')),
#                parseInt(@model.get('three_month_value_gain_to_today')),
#                parseInt(@model.get('six_month_value_gain_to_today')),
#                parseInt(@model.get('nine_month_value_gain_to_today')),
#                parseInt(@model.get('one_year_value_gain_to_today')),
#                parseInt(@model.get('two_year_value_gain_to_today')),
#                parseInt(@model.get('three_year_value_gain_to_today'))
#              ],
#        type: 'spline'
#      }]
#    });
#
#    window.chart_index = new Highcharts.Chart({
#       chart: {
#          renderTo: "chart_index_"+@model.id,
#          type: 'column'
#       },
#       title: {
#          text: 'Portfolio vs Indices'
#       },
#       xAxis: {
#          opposite: true,
#          categories: ['1 Day', '1 Week', '1 Month', '3 Month', '6 Month', '9 Month', '1 Year', '2 Year','3 Year']
#       },
#       yAxis: {
#          title: {
#             text: 'Price % delta'
#          }
#       },
#       plotOptions: {
#         column: {
#            stacking: 'normal'
#         }
#       },
#       series: [{
#         name: 'Portfolio',
#         data: [
#                 parseInt(@model.get('day_price_gain_percent_delta')),
#                 parseInt(@model.get('week_price_gain_percent_delta')),
#                 parseInt(@model.get('one_month_price_gain_percent_delta')),
#                 parseInt(@model.get('three_month_price_gain_percent_delta')),
#                 parseInt(@model.get('six_month_price_gain_percent_delta')),
#                 parseInt(@model.get('nine_month_price_gain_percent_delta')),
#                 parseInt(@model.get('one_year_price_gain_percent_delta')),
#                 parseInt(@model.get('two_year_price_gain_percent_delta')),
#                 parseInt(@model.get('three_year_price_gain_percent_delta'))
#               ]
#       }, {
#         name: 'Dow Jones Ind. Avg',
#         data: [
#                 parseInt(window.DJI.get('day_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('week_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('one_month_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('three_month_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('six_month_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('nine_month_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('one_year_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('two_year_price_gain_percent_delta')),
#                 parseInt(window.DJI.get('three_year_price_gain_percent_delta'))
#               ]
#       }]
#    });






  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.StockHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.stock_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.FundHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.fund_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

class window.EtfHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.etf_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.BondHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.bond_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.CdHoldingView extends Backbone.View

  tagName: "tbody"


  initialize: ->
    @model.view = this
    @model.bind('destroy', @remove, this);

  render: ->
    elem = $(@el).append(ich.cd_holding_template(@model.toJSON()));
    $(elem).hide();
    $("#portfolio-holding-" + @model.get('portfolio_id')).append(elem);
    $(elem).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

