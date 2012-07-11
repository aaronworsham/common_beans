

  #ETF

class window.AddEtfHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
            $(document).trigger('close.facebox')
            p = Portfolios.get(model.get('portfolio_id'))
            model.portfolio = p
            holding = model
            p.fetch(
              { success: (model, resp) ->
                EtfHoldings.add(holding)
                EtfHoldingCharts.add(holding)

              }
            )
         error : (model, resp) ->
          response = JSON.parse(resp.responseText)
          humane.log(HumaneFormatValidation(resp))
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        etf_holding: {
          etf_ticker_id: this.$("#etf_holding_etf_ticker_id").val(),
          starting_units: this.$("#etf_holding_starting_units").val(),
          starting_price: this.$("#etf_holding_starting_price").val(),
          purchased_at: this.$("input[name=purchased_at]").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }




  #fund

class window.AddFundHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
            $(document).trigger('close.facebox')
            p = Portfolios.get(model.get('portfolio_id'))
            model.portfolio = p
            holding = model
            p.fetch(
              { success: (model, resp) ->
                FundHoldings.add(holding)
                FundHoldingCharts.add(holding)
              }
            )
         error : (model, resp) ->
          response = JSON.parse(resp.responseText)
          humane.log(HumaneFormatValidation(resp))
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        fund_holding: {
          fund_ticker_id: this.$("#fund_holding_fund_ticker_id").val(),
          starting_units: this.$("#fund_holding_starting_units").val(),
          starting_price: this.$("#fund_holding_starting_price").val(),
          purchased_at: this.$("input[name=purchased_at]").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }


  #multi

class window.AddMultiHoldingView extends Backbone.View

    el: '#facebox'

    submit: =>
      @model.save(this.serialize(),
        { success : (model, resp)->
            $(document).trigger('close.facebox')
            p = Portfolios.get(model.get('portfolio_id'))
            model.portfolio = p
            holding = model
            p.fetch(
              { success: (model, resp) ->
                MultiHoldings.add(holding)
                MultiHoldingCharts.add(holding)
              }
            )
         error : (model, resp) ->
          response = JSON.parse(resp.responseText)
          humane.log(HumaneFormatValidation(resp))
        }
      );

    serialize: =>
      return {
          authenticity_token: this.$("input[name=authenticity_token]").val(),
          multi_holding: {
            name: this.$("#multi_holding_name").val(),
            portfolio_id: @model.get('portfolio_id')
          }
        }




#stock

class window.AddStockHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
            $(document).trigger('close.facebox')
            p = Portfolios.get(model.get('portfolio_id'))
            model.portfolio = p
            holding = model
            p.fetch(
              { success: (model, resp) ->
                StockHoldings.add(holding)
                StockHoldingCharts.add(holding)
              }
            )
        error : (model, resp) ->
          response = JSON.parse(resp.responseText)
          humane.log(HumaneFormatValidation(resp))
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          purchased_at: this.$("input[name=purchased_at]").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }




$ ->

  $('.add-holding').live('click', (e) ->
    portfolio = Portfolios.get($(@).attr('data-portfolio-id'))
    securityName = $(@).attr('data-security-name')
    className = capitaliseFirstLetter(securityName)+'HoldingModel'
    viewName = 'Add'+capitaliseFirstLetter(securityName)+'HoldingView'

    $.facebox({div:'#add-'+securityName+'-form'});
    $("#facebox .date_picker").datepicker();
    $('#facebox .create_link').click( ->
      holding = new window[className]({portfolio_id:portfolio.id});
      view = new window[viewName]({model:holding});
      view.submit();

    );
    $('#facebox form').submit((e)->
      e.stopPropegation
      holding = new window[className]({portfolio_id:portfolio.id});
      view = new window[viewName]({model:holding});
      view.submit();
      
      return false
    );


  );



