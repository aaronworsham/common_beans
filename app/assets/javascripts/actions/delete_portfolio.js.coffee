$ ->
  $('.delete-portfolio').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))
    portfolio.destroy({success : ->
      Portfolios.remove(portfolio)
    })
  );
