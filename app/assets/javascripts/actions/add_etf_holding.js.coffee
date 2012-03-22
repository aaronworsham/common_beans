$ ->
  $('.add-etf').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-fund-form'});
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