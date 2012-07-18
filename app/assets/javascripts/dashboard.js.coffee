###
= require application
= require_tree ./models
= require_tree ./views
= require_tree ./collections
= require_tree ./actions
= require highcharts
= require highcharts-theme
= require currency_formatter


###




$ ->

  $( "#nav" ).tabs();
  $('.accordion').accordion();

  $('button.buy_button[rel*=facebox], button.sell_button[rel*=facebox]').live('click', (e)->
    if e.currentTarget.className == 'buy_button'
      url_root = '/buys';
    else
      url_root = '/sells';

    e.stopPropagation();
    $.facebox({div:'#buy-shares'});
    holding_id = $(@).attr('data_holding_id');

    submit_form = ->
      event = new StockEventModel({holding_id:holding_id});
      event.urlRoot = url_root
      view = new TrackerFaceboxEventSharesView({model:event});
      view.submit();
      $(document).trigger('close.facebox')

    $('#facebox .record_link').click( ->
      submit_form();
    );

    $('#facebox form').submit( ->
      submit_form();
    );

    return false;
  );

  $('')

  $('.holding-header').live('click', ->
    type = $(@).attr('data-holding-type')
    id = $(@).attr('data-holding-id')
    $(@).find('td.arrow').hide()
    if($(@).find('td.arrow').text() == '>')
      $(@).find('td.arrow').text('V')
    else
      $(@).find('td.arrow').text('>')
    $(@).find('td.arrow').fadeIn('slow')
    $("#"+type+'-events-for-holding-'+id).slideToggle('slow')
  )

  $('.portfolio-header:visible tr.clickable').live('click', ->
    $('.portfolio-header:visible tr.expandable').toggle('slow')
  )

  $('input.promptable').each((i) ->
    $(this).addClass('input-prompt-' + i);
    promptSpan = $('<span class="input-prompt"/>');
    $(promptSpan).attr('id', 'input-prompt-' + i);
    $(promptSpan).append($(this).attr('data-prompt'));
    $(promptSpan).click( ->
      $(this).hide();
      $('.' + $(this).attr('id')).focus();
    )
    if($(this).val() != '')
      $(promptSpan).hide();
    $(this).before(promptSpan);
    $(this).focus(->
      $('#input-prompt-' + i).hide();
    )
    $(this).blur(->
      if($(this).val() == '')
        $('#input-prompt-' + i).show();
    )
   );

  $('button#send_friend_request').live('click',->
    id = $('button#send_friend_request').siblings('#send_friend_request_id').val()
    token = $('meta[name="csrf-token"]').attr('content')
    $.post('trust', {
        'id':id,
        'authenticity_token': token
      },(data)->
        console.log(data)
      ,'json')
  )








