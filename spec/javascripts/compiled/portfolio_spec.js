(function() {
  describe('Portfolio model', function() {
    return describe('when instantiated', function() {
      return it('should exhibit attributes', function() {
        var portfolio;
        portfolio = new Portfolio({
          title: 'Rake leaves'
        });
        return expect(portfolio.get('title')).toEqual('Rake leaves');
      });
    });
  });
}).call(this);
