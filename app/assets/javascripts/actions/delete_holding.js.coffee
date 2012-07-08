$ ->

  $('.delete-bond-holding').live('click', (e) ->
    holding = BondHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );

$ ->

  $('.delete-cd-holding').live('click', (e) ->
    holding = CdHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );

$ ->

  $('.delete-etf-holding').live('click', (e) ->
    holding = EtfHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );
$ ->

  $('.delete-fund-holding').live('click', (e) ->
    holding = FundHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );

$ ->

  $('.delete-multi-holding').live('click', (e) ->
    holding = MultiHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );

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
