# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# 


class window.FaceboxEventSharesView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          StockEvents.add(model);
          model.holding.fetch();
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        event: {
          shares: this.$("#event_shares").val(),
          price: this.$("#event_price").val(),
          'date_of_event(1i)': this.$("#event_date_of_event_1i").val(),
          'date_of_event(2i)': this.$("#event_date_of_event_2i").val(),
          'date_of_event(3i)': this.$("#event_date_of_event_3i").val(),
          'date_of_event(4i)': this.$("#event_date_of_event_4i").val(),
          'date_of_event(5i)': this.$("#event_date_of_event_5i").val(),
          ticker_id: @model.holding.get('ticker_id'),
          holding_id: @model.holding.id,
          type: @model.get('type')
        }
      }


class window.FaceboxAddPortfolioView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          Portfolios.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        portfolio: {
          name: this.$("#portfolio_name").val(),
        }
      }

class window.FaceboxAddHoldingView extends Backbone.View
 
  el: '#facebox'

  submit: => 
    @model.save(this.serialize(), 
        { success : (model, resp)->
          Holdings.add(model)
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
          portfolio_id: @model.get('portfolio_id')
        }
      }




$ -> 

  $('button.buy_button[rel*=facebox], button.sell_button[rel*=facebox]').live('click', (e)->
    if e.currentTarget.className == 'buy_button'
      url_root = '/buys';
    else
      url_root = '/sells';
    
    e.stopPropagation();
    $.facebox({div:'#buy-shares'});
    holding_id = $(this).attr('data_holding_id');

    submit_form = ->
      event = new StockEvent({holding_id:holding_id});
      event.urlRoot = url_root
      view = new FaceboxEventSharesView({model:event});
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





  $('button#add-portfolio').click((e) ->
    e.stopPropagation();
    $.facebox({div:'#add-portfolio-form'});
    $('#facebox .create_link').click( ->
      portfolio = new Portfolio;
      view = new FaceboxAddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
    );
    $('#facebox form').submit( ->
      portfolio = new Portfolio;
      view = new FaceboxAddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
      return false;
    );
    return false;

  );

  $('button.add-holding').live('click', (e) ->
    e.stopPropagation();
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))
    $.facebox({div:'#add-holding-form'});
    $('#facebox .create_link').click( ->
      holding = new Holding({portfolio_id:portfolio.id});
      view = new FaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );

    $('#facebox form').submit( ->
      holding = new Holding({portfolio_id:portfolio.id});
      view = new FaceboxAddHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );
    return false;

  );

  $('.remove-portfolio').live('click',  ->
    p = Portfolios.get($(this).attr('data-portfolio-id'))
    p.destroy();
  );
  $('.remove-holding').live('click',  ->
    h = Holdings.get($(this).attr('data-holding-id'))
    h.destroy();
  );
  $('.remove-event').live('click',  ->
    e = StockEvents.get($(this).attr('data-event-id'))
    holding = e.holding
    e.destroy(
      { success : (model, resp)->
        holding.fetch();
      }
    );
  );


