$ ->

  $('.holding-drawer .edit-holding').live('click', (e) ->
    holding_id = $(@).attr('data-holding-id')
    type = $(@).attr('data-security-name')
    $.ajax('/'+type+'_holdings/'+holding_id+'/edit')
      .success((data)->
        $.facebox(data);
        $( "#facebox .date_picker" ).datepicker();
      );
  );

  $('#facebox form.edit-holding').live('submit', (e) ->
    e.stopPropegation
    holding_id = $(@).attr('data-holding-id')
    collection = $(@).attr('data-collection-name')
    holding = window[collection].get(holding_id)
    holding.set({authenticity_token: $("#facebox form.edit-holding input[name=authenticity_token]").val()})
    holding.set($(@).serializeObject());
    holding.save();
    $.facebox.close();
  );
