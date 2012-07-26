securities = ['stock', 'fund', 'etf']

for security in securities
  do (security) ->
    capSecurity = window.capitaliseFirstLetter(security)
    denom = if security == 'stock' then 'shares' else 'units'
    class window['Add'+capSecurity+'BuyView'] extends Backbone.View

      el: '#facebox'

      submit: =>
        this.set_form_attributes()
        @model.save({},
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

      set_form_attributes: =>
        sec = new Object
        sec[denom]= this.$("#"+security+"_buy_"+denom).val()
        sec['price']= this.$("#"+security+"_buy_price").val()
        sec['executed_at']= this.$("#"+security+"_buy_executed_at").val()
        sec[security+'_holding_id'] = @model.get('holding_id')
        sec[security+'_ticker_id'] = @model.get('ticker_id')
        @model.set(sec);


    class window['Add'+capSecurity+'SellView'] extends Backbone.View

      el: '#facebox'

      submit: =>
        this.set_form_attributes()
        @model.save({},
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

      set_form_attributes: =>
        sec = new Object
        sec[denom]= this.$("#"+security+"_sell_"+denom).val()
        sec['price']= this.$("#"+security+"_sell_price").val()
        sec['executed_at']= this.$("#"+security+"_sell_executed_at").val()
        sec[security+'_holding_id'] = @model.get('holding_id')
        sec[security+'_ticker_id'] = @model.get('ticker_id')
        @model.set(sec);

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






