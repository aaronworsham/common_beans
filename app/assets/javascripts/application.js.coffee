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
    $(warmlist)
      .find('h3')
        .text(title)
      .end()
      .find('.add-holding')
        .attr('data-portfolio-id', id)
      .end()
      .fadeIn('fast');
    callback.call();
hotlistMenu = new HotList

$ ->
  $('#main-logo').click( ->
    window.location = "/"
  );




  $('#nav li.selectable').live("click", ->
    id = $(@).attr('data-id');
    title = $(@).attr('data-label');
    $('#nav li.selectable').each((i,v) ->
      $(v).removeClass('selected');
    );
    $(@).addClass('selected');
    hotlistMenu.select(id, title, '#warmlist-portfolios', ()->
      $('.portfolio-content').hide()
      $('#portfolio-content-'+id).fadeIn('fast');
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




