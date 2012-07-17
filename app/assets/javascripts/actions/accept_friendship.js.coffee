$ ->

  $('a.accept-friendship').live('click', (e) ->
    friendship = FromInvites.get($(this).attr('data-id'))

    friendship.accept()


  );
