describe 'Portfolio model', ->
  describe 'when new', ->
    beforeEach ->
      @portfolio = new PortfolioModel
    it 'should exhibit attributes', ->
      expect(@portfolio.get('name')).toBeUndefined();
      expect(@portfolio.id).toBeUndefined();

    it 'should set a urlRoot to the model', ->
      expect(@portfolio.url()).toEqual('/portfolios');

  describe 'when instantiated', ->
    beforeEach ->
      @portfolio = new PortfolioModel(@fixtures.PortfolioModel.attributes)
    it 'should exhibit attributes', ->
      expect(@portfolio.get('name')).toEqual('main');
      expect(@portfolio.id).toEqual(1);

    it 'should set a urlRoot to the model', ->
      expect(@portfolio.url()).toEqual('/portfolios/1');

    describe "on fetch", ->
      beforeEach ->
        jasmine.Ajax.useMock();
        @onSuccess = jasmine.createSpy('onSuccess');
        @onError = jasmine.createSpy('onError');
        @portfolio.fetch({success:@onSuccess, error:@onError})
        @request = mostRecentAjaxRequest();


      it "calls onSuccess with updated info", ->

        @request.response(TestResponses.Portfolio.success);
        expect(@onSuccess).toHaveBeenCalled();
        expect(@portfolio.get('name')).toEqual('Update')

describe 'Portfolio Collections', ->
  describe 'for Tracker', ->

    beforeEach ->
      @portfolios = new TrackerPortfolioCollection


    it 'should be able to add a portfolio model', ->
      expect(@portfolios.length).toEqual(0)
      @portfolios.add(@portfolio)
      expect(@portfolios.length).toEqual(1)

    it 'should have a TrackerPortfolios object', ->
      expect(TrackerPortfolios).toBeDefined()

    it 'should call addOneView on reset', ->
      spyOn(TrackerPortfolios, 'addOneView')
      TrackerPortfolios.reset({name:'bob'})
      expect(TrackerPortfolios.length).toBe(1)
      expect(TrackerPortfolios.addOneView).toHaveBeenCalled();

    it 'should call addOneView on add of new portfolio', ->
      spyOn(TrackerPortfolios, 'addOneView').andCallThrough()
      portfolio = new PortfolioModel({id:1,name:'test'})
      TrackerPortfolios.add(portfolio)
      expect(TrackerPortfolios.addOneView).toHaveBeenCalled();

  describe 'for Dashboard', ->

    beforeEach ->
      @portfolios = new DashboardPortfolioCollection


    it 'should be able to add a portfolio model', ->
      expect(@portfolios.length).toEqual(0)
      @portfolios.add(@portfolio)
      expect(@portfolios.length).toEqual(1)

    it 'should have a DashboardPortfolios object', ->
      expect(DashboardPortfolios).toBeDefined()

    it 'should call addOneView on reset', ->
      spyOn(DashboardPortfolios, 'addOneView')
      DashboardPortfolios.reset({name:'bob'})
      expect(DashboardPortfolios.length).toBe(1)
      expect(DashboardPortfolios.addOneView).toHaveBeenCalled();

    it 'should call addOneView on add of new portfolio', ->
      spyOn(DashboardPortfolios, 'addOneView').andCallThrough()
      portfolio = new PortfolioModel({id:1,name:'test'})
      DashboardPortfolios.add(portfolio)
      expect(DashboardPortfolios.addOneView).toHaveBeenCalled();






