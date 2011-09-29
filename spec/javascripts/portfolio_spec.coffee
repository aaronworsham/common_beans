describe 'Portfolio model', ->
  describe 'when instantiated', ->
    it 'should exhibit attributes', ->
      portfolio = new Portfolio
        title: 'Rake leaves'
      expect(portfolio.get('title')).toEqual('Rake leaves');
