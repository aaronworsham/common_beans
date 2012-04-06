$ ->

  $('.delete-multi-holding').live('click', (e) ->
    holding = MultiHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );