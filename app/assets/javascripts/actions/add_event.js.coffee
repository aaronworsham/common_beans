class window.AddFundBuyView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          model.holding().fetch(
            { success: ->
              model.holding().view.update()
              FundBuys.add(model)
            }
          )


        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        fund_buy: {
          units: this.$("#fund_buy_units").val(),
          price: this.$("#fund_buy_price").val(),
          'executed_at(1i)': this.$("#fund_buy_executed_at_1i").val(),
          'executed_at(2i)': this.$("#fund_buy_executed_at_2i").val(),
          'executed_at(3i)': this.$("#fund_buy_executed_at_3i").val(),
          'executed_at(4i)': this.$("#fund_buy_executed_at_4i").val(),
          'executed_at(5i)': this.$("#fund_buy_executed_at_5i").val(),
          fund_holding_id: @model.get('holding_id'),
          fund_ticker_id: @model.get('ticker_id')
        }
      }




class window.AddFundSellView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          FundSells.add(model)
          model.holding().fetch(
            { success: ->
              model.holding().view.update()
            }
          )
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        fund_sell: {
          units: this.$("#fund_sell_units").val(),
          price: this.$("#fund_sell_price").val(),
          'executed_at(1i)': this.$("#fund_sell_executed_at_1i").val(),
          'executed_at(2i)': this.$("#fund_sell_executed_at_2i").val(),
          'executed_at(3i)': this.$("#fund_sell_executed_at_3i").val(),
          'executed_at(4i)': this.$("#fund_sell_executed_at_4i").val(),
          'executed_at(5i)': this.$("#fund_sell_executed_at_5i").val(),
          fund_holding_id: @model.get('holding_id'),
          fund_ticker_id: @model.get('ticker_id')
        }
      }





class window.AddStockBuyView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          model.holding().fetch(
            { success: ->
              model.holding().view.update()
              StockBuys.add(model)
            }
          )


        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_buy: {
          shares: this.$("#stock_buy_shares").val(),
          price: this.$("#stock_buy_price").val(),
          'executed_at(1i)': this.$("#stock_buy_executed_at_1i").val(),
          'executed_at(2i)': this.$("#stock_buy_executed_at_2i").val(),
          'executed_at(3i)': this.$("#stock_buy_executed_at_3i").val(),
          'executed_at(4i)': this.$("#stock_buy_executed_at_4i").val(),
          'executed_at(5i)': this.$("#stock_buy_executed_at_5i").val(),
          stock_holding_id: @model.get('holding_id'),
          stock_ticker_id: @model.get('ticker_id')
        }
      }





class window.AddStockSellView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          StockSells.add(model)
          model.holding().fetch(
            { success: ->
              model.holding().view.update()
            }
          )
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_sell: {
          shares: this.$("#stock_sell_shares").val(),
          price: this.$("#stock_sell_price").val(),
          'executed_at(1i)': this.$("#stock_sell_executed_at_1i").val(),
          'executed_at(2i)': this.$("#stock_sell_executed_at_2i").val(),
          'executed_at(3i)': this.$("#stock_sell_executed_at_3i").val(),
          'executed_at(4i)': this.$("#stock_sell_executed_at_4i").val(),
          'executed_at(5i)': this.$("#stock_sell_executed_at_5i").val(),
          stock_holding_id: @model.get('holding_id'),
          stock_ticker_id: @model.get('ticker_id')
        }
      }



$ ->


  $('.add-event').live('click', (e) ->
    securityName = $(@).attr('data-security-name')
    eventType = $(@).attr('data-event-type')
    holding = window[capitaliseFirstLetter(securityName)+'Holdings'].get($(this).attr('data-holding-id'))
    className = capitaliseFirstLetter(securityName)+capitaliseFirstLetter(eventType)+'Model'
    viewName = 'Add'+capitaliseFirstLetter(securityName)+capitaliseFirstLetter(eventType)+'View'

    $.facebox({div:'#'+eventType+'-'+securityName});

    $('#facebox .record_link').click( ->
      action = new window[className]({
        holding_id:holding.id,
        ticker_id:holding.get(securityName+'_ticker_id')
      });
      view = new window[viewName]({model:action});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );






