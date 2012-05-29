$ ->

  $('.edit-holding').live('click', (e) ->
    holding_id = $(@).attr('data-holding-id')
    type = $(@).attr('data-security-name')
    $.ajax('/'+type+'_holdings/'+holding_id+'/edit')
      .success((data)->
        $.facebox(data);
      );




  );