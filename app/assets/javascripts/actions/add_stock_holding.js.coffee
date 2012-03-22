$ ->

  $('.add-stock').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-stock-form'});

    $('#facebox .create_link').click( ->
      holding = new StockHoldingModel({portfolio_id:portfolio.id});
      view = new AddStockHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );