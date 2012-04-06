$ ->

  $('.delete-stock-holding').live('click', (e) ->
    holding = StockHoldings.get($(this).attr('data-holding-id'))
    holding.destroy({success : ->
      StockHoldings.remove(holding)
      id = holding.get('portfolio_id')
      stocks = StockHoldings.where({portfolio_id : parseInt(id)})
      if(stocks.length == 0)
        $("#portfolio-stocks-"+id).hide();
    })
  );