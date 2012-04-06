$ ->

  $('.delete-stock-holding').live('click', (e) ->
    holding = StockHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );