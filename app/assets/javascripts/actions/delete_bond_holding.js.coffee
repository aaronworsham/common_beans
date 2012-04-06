$ ->

  $('.delete-bond-holding').live('click', (e) ->
    holding = BondHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );