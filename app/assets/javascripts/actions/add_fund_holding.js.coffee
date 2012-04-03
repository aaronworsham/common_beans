class window.AddFundHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          FundHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        fund_holding: {
          fund_ticker_id: this.$("#fund_holding_fund_ticker_id").val(),
          starting_units: this.$("#fund_holding_starting_units").val(),
          starting_price: this.$("#fund_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#fund_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#fund_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#fund_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#fund_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#fund_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }


$ ->

  $('.add-fund').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-fund-form'});
    $('#facebox .create_link').click( ->
      holding = new FundHoldingModel({portfolio_id:portfolio.id});
      view = new AddFundHoldingView({model:holding});
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