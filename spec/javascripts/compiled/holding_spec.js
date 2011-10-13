(function() {
  describe('Holding model', function() {
    describe('when new', function() {
      beforeEach(function() {
        return this.holding = new HoldingModel;
      });
      it('should exhibit attributes', function() {
        expect(this.holding.get('name')).toBeUndefined();
        return expect(this.holding.id).toBeUndefined();
      });
      return it('should set a urlRoot to the model', function() {
        return expect(this.holding.url()).toEqual('/holdings');
      });
    });
    return describe('when instantiated', function() {
      beforeEach(function() {
        return this.holding = new HoldingModel(this.fixtures.HoldingModel.attributes);
      });
      it('should exhibit attributes', function() {
        expect(this.holding.get('net_shares')).toEqual(4000);
        return expect(this.holding.id).toEqual(1);
      });
      it('should set a urlRoot to the model', function() {
        return expect(this.holding.url()).toEqual('/holdings/1');
      });
      return describe("on fetch", function() {
        beforeEach(function() {
          jasmine.Ajax.useMock();
          this.onSuccess = jasmine.createSpy('onSuccess');
          this.onError = jasmine.createSpy('onError');
          this.holding.fetch({
            success: this.onSuccess,
            error: this.onError
          });
          return this.request = mostRecentAjaxRequest();
        });
        return it("calls onSuccess with updated info", function() {
          this.request.response(TestResponses.Holding.success);
          expect(this.onSuccess).toHaveBeenCalled();
          return expect(this.holding.get('portfolio_id')).toEqual(4);
        });
      });
    });
  });
  describe('Holding Collections', function() {
    describe('for Tracker', function() {
      beforeEach(function() {
        return this.holdings = new TrackerHoldingCollection;
      });
      it('should be able to add a holding model', function() {
        expect(this.holdings.length).toEqual(0);
        this.holdings.add(this.holding);
        return expect(this.holdings.length).toEqual(1);
      });
      it('should have a TrackerHoldings object', function() {
        return expect(TrackerHoldings).toBeDefined();
      });
      it('should call addOneView on reset', function() {
        spyOn(TrackerHoldings, 'addOneView');
        TrackerHoldings.reset({
          name: 'bob'
        });
        expect(TrackerHoldings.length).toBe(1);
        return expect(TrackerHoldings.addOneView).toHaveBeenCalled();
      });
      return it('should call addOneView on add of new holding', function() {
        var holding;
        spyOn(TrackerHoldings, 'addOneView').andCallThrough();
        holding = new HoldingModel({
          id: 1,
          name: 'test'
        });
        TrackerHoldings.add(holding);
        return expect(TrackerHoldings.addOneView).toHaveBeenCalled();
      });
    });
    return describe('for Dashboard', function() {
      beforeEach(function() {
        return this.holdings = new DashboardHoldingCollection;
      });
      it('should be able to add a holding model', function() {
        expect(this.holdings.length).toEqual(0);
        this.holdings.add(this.holding);
        return expect(this.holdings.length).toEqual(1);
      });
      it('should have a DashboardHoldings object', function() {
        return expect(DashboardHoldings).toBeDefined();
      });
      it('should call addOneView on reset', function() {
        spyOn(DashboardHoldings, 'addOneView');
        DashboardHoldings.reset({
          name: 'bob'
        });
        expect(DashboardHoldings.length).toBe(1);
        return expect(DashboardHoldings.addOneView).toHaveBeenCalled();
      });
      return it('should call addOneView on add of new holding', function() {
        var holding;
        spyOn(DashboardHoldings, 'addOneView').andCallThrough();
        holding = new HoldingModel({
          id: 1,
          name: 'test'
        });
        DashboardHoldings.add(holding);
        return expect(DashboardHoldings.addOneView).toHaveBeenCalled();
      });
    });
  });
}).call(this);
