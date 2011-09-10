# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

###
=require profiles
###


class window.TrackerView extends Backbone.View

  initialize: ->
    Profiles.bind('add',   @addOneProfile, this);
    Profiles.bind('reset', @addAllProfiles, this);
    Profiles.bind('all',   @render, this);
    Holdings.bind('add',   @addOneHolding, this);
    Holdings.bind('reset', @addAllHoldings, this);
    Holdings.bind('all',   @render, this);
    StockEvents.bind('add',   @addOneStockEvent, this);
    StockEvents.bind('reset', @addAllStockEvents, this);
    StockEvents.bind('all',   @render, this);


  el: '#Content'

  addOneProfile: (profile)->
    view = new ProfileView({model: profile});
    view.render(); 

  addAllProfiles: ->
      Profiles.each(@addOneProfile);

  addOneHolding: (holding)->
    view = new HoldingView({model: holding});
    view.render(); 

  addAllHoldings: ->
      Holdings.each(@addOneHolding);

  addOneStockEvent: (event)->
    view = new StockEventView({model: event});
    view.render(); 

  addAllStockEvents: ->
    StockEvents.each(@addOneStockEvent);



class window.FaceboxBuySharesView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          StockEvents.add(model)
          StockEvents.trigger('add', model);
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        buy: {
          shares: this.$("#buy_shares").val(),
          price: this.$("#buy_price").val(),
          'date_of_event(1i)': this.$("#buy_date_of_event_1i").val(),
          'date_of_event(2i)': this.$("#buy_date_of_event_2i").val(),
          'date_of_event(3i)': this.$("#buy_date_of_event_3i").val(),
          'date_of_event(4i)': this.$("#buy_date_of_event_4i").val(),
          'date_of_event(5i)': this.$("#buy_date_of_event_5i").val(),
          ticker_id: @model.holding.get('ticker_id'),
          holding_id: @model.holding.id,
        }
      }

class window.FaceboxSellSharesView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          StockEvents.add(model)
          StockEvents.trigger('add', model);
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        sell: {
          shares: this.$("#sell_shares").val(),
          price: this.$("#sell_price").val(),
          'date_of_event(1i)': this.$("#sell_date_of_event_1i").val(),
          'date_of_event(2i)': this.$("#sell_date_of_event_2i").val(),
          'date_of_event(3i)': this.$("#sell_date_of_event_3i").val(),
          'date_of_event(4i)': this.$("#sell_date_of_event_4i").val(),
          'date_of_event(5i)': this.$("#sell_date_of_event_5i").val(),
          ticker_id: @model.holding.get('ticker_id'),
          holding_id: @model.holding.id,
        }
      }

class window.FaceboxAddProfileView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          Profiles.add(model)
          Profiles.trigger('add', model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        profile: {
          name: this.$("#profile_name").val(),
        }
      }

class window.FaceboxAddHoldingView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          Holdings.add(model)
          Holdings.trigger('add', model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        holding: {
          ticker_id: this.$("#holding_ticker").val(),
          starting_shares: this.$("#holding_starting_shares").val(),
          starting_price: this.$("#holding_starting_price").val(),
          'date_of_purchase(1i)': this.$("#holding_date_of_purchase_1i").val(),
          'date_of_purchase(2i)': this.$("#holding_date_of_purchase_2i").val(),
          'date_of_purchase(3i)': this.$("#holding_date_of_purchase_3i").val(),
          'date_of_purchase(4i)': this.$("#holding_date_of_purchase_4i").val(),
          'date_of_purchase(5i)': this.$("#holding_date_of_purchase_5i").val(),
          profile_id: @model.get('profile_id')
        }
      }




$ -> 

  $('button.buy_button[rel*=facebox]').live('click', (e)->
    e.stopPropagation();
    holding = Holdings.get($(this).attr('data_holding_id'));
    $.facebox({div:'#buy-shares'});
    $('#facebox .record_link').click( ->
      buy = new Buy({holding:holding});
      view = new FaceboxBuySharesView({model:buy});
      view.submit();
      $(document).trigger('close.facebox')

    );
    return false;
  );
  $('button.sell_button[rel*=facebox]').live("click", (e) ->
    e.stopPropagation();
    holding = Holdings.get($(this).attr('data_holding_id'));
    $.facebox({div:'#sell-shares'});
    $('#facebox .record_link').click( ->
      sell = new Sell({holding:holding});
      view = new FaceboxSellSharesView({model:sell});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );

  $('button#add-profile').click((e) ->
    e.stopPropagation();
    $.facebox({div:'#add-profile-form'});
    $('#facebox .create_link').click( ->
      profile = new Profile;
      view = new FaceboxAddProfileView({model:profile});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );

  $('button.add-holding').live('click', (e) ->
    e.stopPropagation();
    profile = Profiles.get($(this).attr('data-profile-id'))
    $.facebox({div:'#add-holding-form'});
    $('#facebox .create_link').click( ->
      holding = new Holding({profile_id:profile.id});
      view = new FaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );




