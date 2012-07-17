class window.FriendPortfolioView extends Backbone.View

  tagName: "div"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = ich.friend_portfolio_template(@model.toJSON());
    $(elem_show).hide();
    events_table = $(elem_show).find("table#friend-events-for-portfolio-"+@model.id+" tbody")
    
    for e in @model.attributes['events']
      do (e) ->
        $(events_table).append(ich.friend_event_template(e))
    
    $('#show-friends-portfolios-content').append(elem_show);
    $(elem_show).fadeIn("slow");

    options = {
      chart: {
           renderTo: 'friend-portfolio-' + @model.id + '-graph',
           plotBackgroundColor: null,
           plotBorderWidth: null,
           plotShadow: false
      },
      title: {
        text: 'Securities Distribution'
      },

      lotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            color: '#000000',
            connectorColor: '#000000',
          }
        }
      },
      series: [{
        type: 'pie',
        name: 'Holding Percentage',
        data: []
      }]
    };

    for v in @model.attributes.distribution
      options.series[0].data.push([v['holding_name'],v['ratio']])
    chart = new Highcharts.Chart(options);



class window.FriendView extends Backbone.View

  tagName: "td"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = $(@el).append(ich.friend_share_template(@model.toJSON()));
    $(elem_show).hide();
    
    $('#friends-content table tbody tr').append(elem_show);
    $(elem_show).fadeIn("slow");
  
  remove: ->
    console.log('Attempting to remove friendship')
    console.log(@el)
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
    FromInvites.add(new InviteFromModel(@model.toJSON()))


class window.InviteToView extends Backbone.View

  tagName: "td"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);

  render: ->
    elem_show = $(@el).append(ich.friend_share_template(@model.toJSON()));
    $(elem_show).hide();
    
    $('#invites-to-content table tbody tr').append(elem_show);
    $(elem_show).fadeIn("slow");
  
  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );


class window.InviteFromView extends Backbone.View

  tagName: "td"

  initialize: ->
    @model.view = this
    @model.bind('change', @render, this);
    @model.bind('destroy', @remove, this);
    @model.bind('accept', @accept, this);

  render: ->
    elem_show = $(@el).append(ich.invite_from_template(@model.toJSON()));
    $(elem_show).hide();
    
    $('#invites-from-content table tbody tr').append(elem_show);
    $(elem_show).fadeIn("slow");

  remove: ->
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );

  accept: ->
    console.log('got event')
    $(@el).fadeOut("slow", ->
      $(this).remove();
    );
    Friends.add(new FriendModel(@model.toJSON()))

  
