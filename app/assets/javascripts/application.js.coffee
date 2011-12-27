###
= require jquery
= require jquery-ui
= require autocomplete-rails
= require jquery.facebox
= require backbone
= require ICanHaz
= require date_formatter
###

class HotList
  currentId : 0
  select : (id, title, warmlist, callback) ->
    console.log(id);
    @.currentId = id;
    $('.warmlist').hide();
    $(warmlist)
      .find('h3')
        .text(title)
      .end()
      .find('.add-holding')
        .attr('data-portfolio-id', id)
      .end()
      .slideDown('slow');
    callback.call();
hotlistMenu = new HotList

$ ->
  $('#main-logo').click( ->
    window.location = "/"
  );

  $("#message_bar").tabs({
    select: ->

      $(@).animate({
        height: '500px',
        }, 500, ->
          $(@).find('.messages').show();
          $('#message_close_btn').show();
      );


  });


  $('#message_close_btn').click( ->
      $('#message_bar .messages').hide();
      $('#message_close_btn').hide();
      $('#message_bar').animate({
        height: '65px',
        }, 500

      );

  );

  $('#portfolios-hotlist li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    $('#portfolios-hotlist li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    hotlistMenu.select(id, title, '#warmlist-portfolios', ()->
      $('.portfolio-content').hide()
      $('.portfolio-content#'+title).show();
    );
  );
  $('#groups-hotlist li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    hotlistMenu.select(id, title, '#warmlist-groups')
  );
  $('#friends-hotlist li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    hotlistMenu.select(id, title, '#warmlist-friends')
  );


fetchMessages = ->
  console.log('getting message');
  $.getJSON('messages').success( (data) ->
    console.log('posting messages...');
    $('a[href=#tab-everyone]').text('Everyone('+data.everyone.length+')');
    $('a[href=#tab-friends]').text('Friends('+data.friend.length+')');
    $('a[href=#tab-groups]').text('Groups('+data.group.length+')');
    $("#tab-everyone table").html('');
    $("#tab-friends table").html('');
    $("#tab-groups table").html('');
    EveryoneMessages.reset(data.everyone);
    FriendMessages.reset(data.friend);
    GroupMessages.reset(data.group);
    console.log('posted messages');

  );

setInterval(fetchMessages, 15000);

