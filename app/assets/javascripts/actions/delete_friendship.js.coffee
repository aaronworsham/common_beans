$ ->

  $('a.delete-friendship').live('click', (e) ->
    friendship = Friends.get($(this).attr('data-id'))

    friendship.destroy()


  );


  $('a.delete-invite-to').live('click', (e) ->
    friendship = ToInvites.get($(this).attr('data-id'))

    friendship.destroy()


  )


  $('a.decline-friendship').live('click', (e) ->
    friendship = FromInvites.get($(this).attr('data-id'))

    friendship.decline()


  )
