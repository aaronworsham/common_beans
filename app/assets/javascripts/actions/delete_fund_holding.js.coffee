$ ->

  $('.delete-fund-holding').live('click', (e) ->
    holding = FundHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );