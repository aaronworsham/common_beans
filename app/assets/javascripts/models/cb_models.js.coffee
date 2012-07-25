securities = ['stock', 'fund', 'bond', 'etf', 'cd', 'multi']
data_points = [
          'starting_price',
          'starting_investment',
          'net_investment',
          'net_return',
          'todays_price',
          'todays_value',
          'total_value_gain',
          'starting_balance',
          'ending_balance',
          'last_known_value',
          'contributions',
          'est_current_value',
          'est_current_gain'
          ]
for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingModel'] extends Backbone.Model
      urlRoot : "/backbone"
      formattedData : ->
        data = @.toJSON()
        for data_point in data_points
          do (data_point) ->
            if data[data_point] isnt null
              data['formatted_'+ data_point] = FormatCurrency(data[data_point])
              if data[data_point] >= 0
                data['formatted_' + data_point + '_class'] = 'positive'
              else
                data['formatted_' + data_point + '_class'] = 'negative'
        return data
      chart: ->
        window[capSecurity+'HoldingCharts'].get(@.id)

    class window[capSecurity+'BuyModel'] extends Backbone.Model
      urlRoot : "/backbone"

      holding: =>
        window[capSecurity+'Holdings'].get(@get(security+'_holding_id'))
      portfolio: =>
        Portfolios.get(@get('portfolio_id')) 

    class window[capSecurity+'SellModel'] extends Backbone.Model
      urlRoot : "/backbone"

      holding: =>
        window[capSecurity+'Holdings'].get(@get(security+'_holding_id'))   
      portfolio: =>
        Portfolios.get(@get('portfolio_id'))    

    class window[capSecurity+'EventModel'] extends Backbone.Model
      urlRoot : "/backbone"

      holding: =>
        window[capSecurity+'Holdings'].get(@get(security+'_holding_id'))
      portfolio: =>
        Portfolios.get(@get('portfolio_id')) 


class window.PortfolioModel extends Backbone.Model
  urlRoot : "/backbone"
  defaults : {
    model_name : 'Portfolio'
  }
  formattedData : ->
    data = @.toJSON()
    for data_point in ['total_value', 'total_value_gain', 'total_gain_ratio']
      do (data_point) ->
        if data[data_point] isnt null
          data['formatted_'+ data_point] = FormatCurrency(data[data_point])
          if data[data_point] >= 0
            data['formatted_' + data_point + '_class'] = 'positive'
          else
            data['formatted_' + data_point + '_class'] = 'negative'
    return data

class window.MultiStatementModel extends Backbone.Model
  urlRoot : "/backbone"
  formattedData : ->
    data = @.toJSON()
    for data_point in data_points
      do (data_point) ->
        if data[data_point] isnt null
          data['formatted_'+ data_point] = FormatCurrency(data[data_point])
          if data[data_point] >= 0
            data['formatted_' + data_point + '_class'] = 'positive'
          else
            data['formatted_' + data_point + '_class'] = 'negative'

    return data
class window.MultiAllocationModel extends Backbone.Model
  urlRoot : "/backbone"
class window.CompareIndicesModel extends Backbone.Model
  urlRoot : "/backbone"
class window.CompareValuesModel extends Backbone.Model
  urlRoot : "/compare_values"
class window.CompareFriendsModel extends Backbone.Model
  urlRoot : "/compare_values"
class window.CompareOthersModel extends Backbone.Model
  urlRoot : "/compare_values"
class window.FriendPortfolioModel extends Backbone.Model
  urlRoot : "/friends_portfolios"
class window.FriendModel extends Backbone.Model
  urlRoot : "/friends"
class window.InviteToModel extends Backbone.Model
  urlRoot : "/friends"
class window.InviteFromModel extends Backbone.Model
  urlRoot : "/friends"

  accept: (opts) ->
    model = this
    url = model.url() + '/accept'
    options = {
        url: url,
        type: 'GET',
        dataType: 'json'
    };

    _.extend(options, opts);
    model.trigger('accept')
    return (this.sync || Backbone.sync).call(this, null, this, options);
  

  
