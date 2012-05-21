var TestResponses = {
  Portfolio: {
    success: {
      status: 200,
      contentType: "application/json; charset=utf-8",
      responseText: '{"created_at":"2011-09-15T23:24:59Z","id":1,"name":"Update","updated_at":"2011-09-15T23:24:59Z","user_id":16}'
    }
  },
  Holding: {
    success: {
      status: 200,
      contentType: "application/json; charset=utf-8",
      responseText: '{"created_at":"Thu, 29 Sep 2011 15:27:48 UTC +00:00", "date_of_purchase":"Thu, 29 Sep 2011 15:24:00 UTC +00:00", "id":98, "net_investment":100, "net_return":100, "net_shares":1000, "portfolio_id":4, "starting_investment":100, "starting_price":1000, "starting_shares":1000, "ticker_id":9708, "updated_at":"Thu, 29 Sep 2011 15:27:48 UTC +00:00", "user_id":16, "ticker_name":"Apple Inc.", "ticker_symbol":"AAPL", "relative_day":"Day 5", "todays_value":50000.0, "total_value_gain":40000.0, "todays_price":50.0, "price_delta":40.0, "day_delta":40.0, "week_delta":40.0, "month_delta":40.0, "year_delta":40.0}'
    }
  }
};