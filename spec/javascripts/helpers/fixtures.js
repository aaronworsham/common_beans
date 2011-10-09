(function() {
  beforeEach(function() {
    return this.fixtures = {
      PortfolioModel: {
        attributes: {
          id: 1,
          name: 'main',
          "todays_value": 50000.0,
          "total_gain": 40000.0,
          "price_delta": 40.0,
          "day_delta": 40.0,
          "week_delta": 40.0,
          "month_delta": 40.0,
          "year_delta": 40.0,
          "dow_delta": 4,
          "s&p_delta": 7,
          "savings_delta": 9,
          "inflation_delta": 10
        },
        update: {
          id: 1,
          name: 'new name'
        }
      },
      HoldingModel: {
        attributes: {
          id: 1,
          "created_at": 'Thu, 29 Sep 2011 15:27:48 UTC +00:00',
          "date_of_purchase": 'Thu, 29 Sep 2011 15:24:00 UTC +00:00',
          "net_investment": 100000,
          "net_return": 10000,
          "net_shares": 4000,
          "portfolio_id": 4,
          "starting_investment": 20000,
          "starting_price": 10,
          "starting_shares": 100,
          "ticker_id": 9875,
          "user_id": 50,
          "ticker_name": "Apple Inc.",
          "ticker_symbol": "AAPL",
          "relative_day": "Day 5",
          "todays_value": 50000.0,
          "total_gain": 40000.0,
          "todays_price": 50.0,
          "price_delta": 40.0,
          "day_delta": 40.0,
          "week_delta": 40.0,
          "month_delta": 40.0,
          "year_delta": 40.0,
          "dow_delta": 4,
          "s&p_delta": 7,
          "savings_delta": 9,
          "inflation_delta": 10
        },
        update: {
          id: 1,
          name: 'new name'
        }
      }
    };
  });
}).call(this);
