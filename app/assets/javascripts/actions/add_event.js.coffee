securities = ['stock', 'fund', 'etf']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    denom = if security == 'stock' then 'shares' else 'units'
    class window['Add'+capSecurity+'BuyView'] extends Backbone.View

      el: '#facebox'

      submit: =>
        @model.save(this.serialize(),
          { success : (model, resp)->
            p = model.portfolio()
            h = model.holding()
            c = h.chart()
            window[capSecurity+'Sells'].add(model)
            window[capSecurity+'Events'].add(model)
            p.fetch(
              { success: ->
                h.fetch(

                )
              }
            )
          }
        );

      serialize: =>
        obj = new Object
        obj['authenticity_token'] = this.$("input[name=authenticity_token]").val()

        sec = new Object
        sec[denom]= this.$("#"+security+"_buy_"+denom).val()
        sec['price']= this.$("#"+security+"_buy_price").val()
        sec['executed_at(1i)']= this.$("#"+security+"_buy_executed_at_1i").val()
        sec['executed_at(2i)']= this.$("#"+security+"_buy_executed_at_2i").val()
        sec['executed_at(3i)']= this.$("#"+security+"_buy_executed_at_3i").val()
        sec['executed_at(4i)']= this.$("#"+security+"_buy_executed_at_4i").val()
        sec['executed_at(5i)']= this.$("#"+security+"_buy_executed_at_5i").val()
        sec[security+'_holding_id'] = @model.get('holding_id')
        sec[security+'_ticker_id'] = @model.get('ticker_id')

        obj[security+'_buy'] = sec
        return obj
    class window['Add'+capSecurity+'SellView'] extends Backbone.View

      el: '#facebox'

      submit: =>
        @model.save(this.serialize(),
          { success : (model, resp)->
            p = model.portfolio()
            h = model.holding()
            window[capSecurity+'Sells'].add(model)
            window[capSecurity+'Events'].add(model)
            p.fetch(
              { success: ->
                h.fetch(
                )
              }
            )
          }
        );

      serialize: =>
        obj = new Object
        obj['authenticity_token'] = this.$("input[name=authenticity_token]").val()

        sec = new Object
        sec[denom]= this.$("#"+security+"_sell_"+denom).val()
        sec['price']= this.$("#"+security+"_sell_price").val()
        sec['executed_at(1i)']= this.$("#"+security+"_sell_executed_at_1i").val()
        sec['executed_at(2i)']= this.$("#"+security+"_sell_executed_at_2i").val()
        sec['executed_at(3i)']= this.$("#"+security+"_sell_executed_at_3i").val()
        sec['executed_at(4i)']= this.$("#"+security+"_sell_executed_at_4i").val()
        sec['executed_at(5i)']= this.$("#"+security+"_sell_executed_at_5i").val()
        sec[security+'_holding_id'] = @model.get('holding_id')
        sec[security+'_ticker_id'] = @model.get('ticker_id')

        obj[security+'_sell'] = sec
        return obj




$ ->


  $('.add-event').live('click', (e) ->
    securityName = $(@).attr('data-security-name')
    capSecurityName = capitaliseFirstLetter(securityName)
    eventType = $(@).attr('data-event-type')
    capEventType = capitaliseFirstLetter(eventType)


    holding = window[capSecurityName+'Holdings'].get($(this).attr('data-holding-id'))
    className = capSecurityName+capEventType+'Model'
    viewName = 'Add'+capSecurityName+capEventType+'View'

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






