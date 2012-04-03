class window.AddEtfHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          EtfHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        etf_holding: {
          etf_ticker_id: this.$("#etf_holding_etf_ticker_id").val(),
          starting_units: this.$("#etf_holding_starting_units").val(),
          starting_price: this.$("#etf_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#etf_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#etf_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#etf_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#etf_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#etf_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }


$ ->
  $('.add-etf').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-etf-form'});
    $('#facebox .create_link').click( ->
      holding = new EtfHoldingModel({portfolio_id:portfolio.id});
      view = new AddEtfHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );

#    $('#facebox form').submit( ->
#      holding = new HoldingModel({portfolio_id:portfolio.id});
#      view = new TrackerFaceboxAddHoldingView({model:holding});
#      view.submit();
#      $(document).trigger('close.facebox')
#    );
#    return false;

  );