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
  describe('Portfolio Collections', function() {
    describe('for Tracker', function() {
      beforeEach(function() {
        return this.portfolios = new TrackerPortfolioCollection;
      });
      it('should be able to add a portfolio model', function() {
        expect(this.portfolios.length).toEqual(0);
        this.portfolios.add(this.portfolio);
        return expect(this.portfolios.length).toEqual(1);
      });
      it('should have a TrackerPortfolios object', function() {
        return expect(TrackerPortfolios).toBeDefined();
      });
      it('should call addOneView on reset', function() {
        spyOn(TrackerPortfolios, 'addOneView');
        TrackerPortfolios.reset({
          name: 'bob'
        });
        expect(TrackerPortfolios.length).toBe(1);
        return expect(TrackerPortfolios.addOneView).toHaveBeenCalled();
      });
      return it('should call addOneView on add of new portfolio', function() {
        var portfolio;
        spyOn(TrackerPortfolios, 'addOneView').andCallThrough();
        portfolio = new PortfolioModel({
          id: 1,
          name: 'test'
        });
        TrackerPortfolios.add(portfolio);
        return expect(TrackerPortfolios.addOneView).toHaveBeenCalled();
      });
    });
    return describe('for Dashboard', function() {
      beforeEach(function() {
        return this.portfolios = new DashboardPortfolioCollection;
      });
      it('should be able to add a portfolio model', function() {
        expect(this.portfolios.length).toEqual(0);
        this.portfolios.add(this.portfolio);
        return expect(this.portfolios.length).toEqual(1);
      });
      it('should have a DashboardPortfolios object', function() {
        return expect(DashboardPortfolios).toBeDefined();
      });
      it('should call addOneView on reset', function() {
        spyOn(DashboardPortfolios, 'addOneView');
        DashboardPortfolios.reset({
          name: 'bob'
        });
        expect(DashboardPortfolios.length).toBe(1);
        return expect(DashboardPortfolios.addOneView).toHaveBeenCalled();
      });
      return it('should call addOneView on add of new portfolio', function() {
        var portfolio;
        spyOn(DashboardPortfolios, 'addOneView').andCallThrough();
        portfolio = new PortfolioModel({
          id: 1,
          name: 'test'
        });
        DashboardPortfolios.add(portfolio);
        return expect(DashboardPortfolios.addOneView).toHaveBeenCalled();
      });
    });
  });
}).call(this);
