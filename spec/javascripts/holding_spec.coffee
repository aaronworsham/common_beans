describe 'Holding model', ->
  describe 'when new', ->
    beforeEach ->
      @holding = new HoldingModel
    it 'should exhibit attributes', ->
      expect(@holding.get('name')).toBeUndefined();
      expect(@holding.id).toBeUndefined();

    it 'should set a urlRoot to the model', ->
      expect(@holding.url()).toEqual('/holdings');

  describe 'when instantiated', ->
    beforeEach ->
      @holding = new HoldingModel(@fixtures.HoldingModel.attributes)
    it 'should exhibit attributes', ->
      expect(@holding.get('net_shares')).toEqual(4000);
      expect(@holding.id).toEqual(1);

    it 'should set a urlRoot to the model', ->
      expect(@holding.url()).toEqual('/holdings/1');

    describe "on fetch", ->
      beforeEach ->
        jasmine.Ajax.useMock();
        @onSuccess = jasmine.createSpy('onSuccess');
        @onError = jasmine.createSpy('onError');
        @holding.fetch({success:@onSuccess, error:@onError})
        @request = mostRecentAjaxRequest();


      it "calls onSuccess with updated info", ->

        @request.response(TestResponses.Holding.success);
        expect(@onSuccess).toHaveBeenCalled();
        expect(@holding.get('portfolio_id')).toEqual(4)

describe 'Holding Collections', ->
  describe 'for Tracker', ->

    beforeEach ->
      @holdings = new TrackerHoldingCollection


    it 'should be able to add a holding model', ->
      expect(@holdings.length).toEqual(0)
      @holdings.add(@holding)
      expect(@holdings.length).toEqual(1)

    it 'should have a TrackerHoldings object', ->
      expect(TrackerHoldings).toBeDefined()

    it 'should call addOneView on reset', ->
      spyOn(TrackerHoldings, 'addOneView')
      TrackerHoldings.reset({name:'bob'})
      expect(TrackerHoldings.length).toBe(1)
      expect(TrackerHoldings.addOneView).toHaveBeenCalled();

    it 'should call addOneView on add of new holding', ->
      spyOn(TrackerHoldings, 'addOneView').andCallThrough()
      holding = new HoldingModel({id:1,name:'test'})
      TrackerHoldings.add(holding)
      expect(TrackerHoldings.addOneView).toHaveBeenCalled();

  describe 'for Dashboard', ->

    beforeEach ->
      @holdings = new DashboardHoldingCollection


    it 'should be able to add a holding model', ->
      expect(@holdings.length).toEqual(0)
      @holdings.add(@holding)
      expect(@holdings.length).toEqual(1)

    it 'should have a DashboardHoldings object', ->
      expect(DashboardHoldings).toBeDefined()

    it 'should call addOneView on reset', ->
      spyOn(DashboardHoldings, 'addOneView')
      DashboardHoldings.reset({name:'bob'})
      expect(DashboardHoldings.length).toBe(1)
      expect(DashboardHoldings.addOneView).toHaveBeenCalled();

    it 'should call addOneView on add of new holding', ->
      spyOn(DashboardHoldings, 'addOneView').andCallThrough()
      holding = new HoldingModel({id:1,name:'test'})
      DashboardHoldings.add(holding)
      expect(DashboardHoldings.addOneView).toHaveBeenCalled();






