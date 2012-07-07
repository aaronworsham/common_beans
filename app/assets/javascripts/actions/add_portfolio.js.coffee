class window.AddPortfolioView extends Backbone.View

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
          portfolio_plan_id: this.$("#portfolio_portfolio_plan").val(),
          portfolio_strategy_id: this.$("#portfolio_portfolio_strategy").val()
        }
      }



$ ->

  $('.add_portfolio_group_action').click((e) ->
    e.stopPropagation();
    $.facebox({div:'#add-portfolio-form'});
    $('#facebox .create_link').click( ->
      portfolio = new PortfolioModel;
      view = new AddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
    );
    $('#facebox form').submit( ->
      portfolio = new PortfolioModel;
      view = new AddPortfolioView({model:portfolio});
      view.submit();
      $(document).trigger('close.facebox')
      return false;
    );
    return false;

  );
