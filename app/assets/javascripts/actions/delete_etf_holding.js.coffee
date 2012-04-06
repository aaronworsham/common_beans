$ ->

  $('.delete-etf-holding').live('click', (e) ->
    holding = EtfHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );