securities = ['stock', 'fund', 'bond', 'etf', 'cd', 'multi']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    class window[capSecurity+'HoldingModel'] extends Backbone.Model
      urlRoot : "/"+security+"_holdings"

    class window[capSecurity+'BuyModel'] extends Backbone.Model
      urlRoot : "/"+security+"_buys"

      holding: =>
       window[capSecurity+'Holdings'].get(@get(security+'_holding_id'))

    class window[capSecurity+'SellModel'] extends Backbone.Model
      urlRoot : "/"+security+"_sells"

      holding: =>
       window[capSecurity+'Holdings'].get(@get(security+'_holding_id'))



class window.PortfolioModel extends Backbone.Model
  urlRoot : "/portfolios"
class window.MultiStatementModel extends Backbone.Model
  urlRoot : "/multi_statements"
class window.CompareIndicesModel extends Backbone.Model
  urlRoot : "/compare_indices"
class window.CompareValuesModel extends Backbone.Model
  urlRoot : "/compare_values"
