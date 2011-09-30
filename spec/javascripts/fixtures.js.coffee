beforeEach ->
  @fixtures =
    PortfolioModel:
      attributes:
        id : 1
        name : 'main'
      update:
        id : 1
        name : 'new name'
