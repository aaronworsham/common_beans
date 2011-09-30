(function() {
  describe('Portfolio model', function() {
    describe('when new', function() {
      beforeEach(function() {
        return this.portfolio = new PortfolioModel;
      });
      it('should exhibit attributes', function() {
        expect(this.portfolio.get('name')).toBeUndefined();
        return expect(this.portfolio.id).toBeUndefined();
      });
      return it('should set a urlRoot to the model', function() {
        return expect(this.portfolio.url()).toEqual('/portfolios');
      });
    });
    return describe('when instantiated', function() {
      beforeEach(function() {
        return this.portfolio = new PortfolioModel(this.fixtures.PortfolioModel.attributes);
      });
      it('should exhibit attributes', function() {
        expect(this.portfolio.get('name')).toEqual('main');
        return expect(this.portfolio.id).toEqual(1);
      });
      it('should set a urlRoot to the model', function() {
        return expect(this.portfolio.url()).toEqual('/portfolios/1');
      });
      return describe("on fetch", function() {
        beforeEach(function() {
          jasmine.Ajax.useMock();
          this.onSuccess = jasmine.createSpy('onSuccess');
          this.onError = jasmine.createSpy('onError');
          this.portfolio.fetch({
            success: this.onSuccess,
            error: this.onError
          });
          return this.request = mostRecentAjaxRequest();
        });
        return it("calls onSuccess with updated info", function() {
          this.request.response(TestResponses.Portfolio.success);
          expect(this.onSuccess).toHaveBeenCalled();
          return expect(this.portfolio.get('name')).toEqual('Update');
        });
      });
    });
  });
}).call(this);
