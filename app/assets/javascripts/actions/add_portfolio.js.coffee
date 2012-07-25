class window.AddPortfolioView extends Backbone.View

  el: '#facebox'

  submit: =>
    this.set_form_attributes()
    @model.save({},
        { success : (model, resp)->
          Portfolios.add(model)
        }
    );

  set_form_attributes: =>
    @model.set({
      name: this.$("#portfolio_name").val(),
      portfolio_plan_id: this.$("#portfolio_portfolio_plan").val(),
      portfolio_strategy_id: this.$("#portfolio_portfolio_strategy").val()
    });



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
