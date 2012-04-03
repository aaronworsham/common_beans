class window.AddMultiHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          MultiHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        multi_holding: {
          name: this.$("#multi_holding_name").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }



$ ->

  $('.add-multi').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-multi-form'});

    $('#facebox .create_link').click( ->
      holding = new MultiHoldingModel({portfolio_id:portfolio.id});
      view = new AddMultiHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );
