$ ->

  $('.delete-cd-holding').live('click', (e) ->
    holding = CdHoldings.get($(this).attr('data-holding-id'))

    holding.destroy()


  );