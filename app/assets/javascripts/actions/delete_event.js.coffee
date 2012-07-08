$ ->

  $('.delete-event').live('click', (e) ->
    event = StockEvents.get($(this).attr('data-id'))
    h = event.holding()
    p = event.portfolio()
    event.destroy(
      { success: ->
        h.fetch(
          { success: ->
            p.fetch()
          }
        )
      }
    )
    return false

  );

