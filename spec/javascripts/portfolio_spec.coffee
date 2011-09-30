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



