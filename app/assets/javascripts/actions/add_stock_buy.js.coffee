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



$ ->

  $('.buy-stock-event').live('click', (e) ->
    holding = StockHoldings.get($(this).attr('data-holding-id'))

    $.facebox({div:'#buy-stock'});

    $('#facebox .record_link').click( ->
      buy = new StockBuyModel({
        holding_id:holding.id,
        ticker_id:holding.get('stock_ticker_id')
      });
      view = new AddStockBuyView({model:buy});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );
