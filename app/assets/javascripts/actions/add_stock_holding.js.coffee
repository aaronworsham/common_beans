class window.AddStockHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          StockHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#stock_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#stock_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#stock_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#stock_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#stock_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }



$ ->

  $('.add-stock').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-stock-form'});

    $('#facebox .create_link').click( ->
      holding = new StockHoldingModel({portfolio_id:portfolio.id});
      view = new AddStockHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );
