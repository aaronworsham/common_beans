# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120123200819) do

  create_table "bond_events", :force => true do |t|
    t.integer  "bond_ticker_id"
    t.integer  "quantity"
    t.integer  "bond_holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "executed_at"
    t.decimal  "roi",                :precision => 15, :scale => 2
    t.decimal  "investment",         :precision => 15, :scale => 2
    t.decimal  "price",              :precision => 9,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
  end

  create_table "bond_holdings", :force => true do |t|
    t.integer  "bond_ticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.decimal  "coupon",             :precision => 5,  :scale => 2
    t.datetime "matures_at"
    t.decimal  "purchase_price",     :precision => 15, :scale => 2
    t.decimal  "face_value",         :precision => 15, :scale => 2
    t.decimal  "expected_yield",     :precision => 5,  :scale => 2
    t.integer  "frequency"
    t.datetime "purchased_at"
    t.integer  "net_quantity"
    t.decimal  "net_investment",     :precision => 15, :scale => 2
    t.decimal  "net_return",         :precision => 15, :scale => 2
    t.integer  "starting_quantity"
    t.string   "name"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y5_value"
    t.float    "y5_gain"
  end

  create_table "bond_tickers", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cd_events", :force => true do |t|
    t.integer  "cd_ticker_id"
    t.integer  "quantity"
    t.integer  "cd_holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "executed_at"
    t.decimal  "roi",                :precision => 15, :scale => 2
    t.decimal  "investment",         :precision => 15, :scale => 2
    t.decimal  "price",              :precision => 9,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
  end

  create_table "cd_holdings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.decimal  "coupon",             :precision => 5,  :scale => 2
    t.datetime "matures_at"
    t.decimal  "purchase_price",     :precision => 15, :scale => 2
    t.decimal  "face_value",         :precision => 15, :scale => 2
    t.decimal  "expected_yield",     :precision => 5,  :scale => 2
    t.integer  "frequency"
    t.datetime "purchased_at"
    t.integer  "net_quantity"
    t.decimal  "net_investment",     :precision => 15, :scale => 2
    t.decimal  "net_return",         :precision => 15, :scale => 2
    t.integer  "starting_quantity"
    t.string   "name"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y5_value"
    t.float    "y5_gain"
  end

  create_table "etf_events", :force => true do |t|
    t.integer  "etf_ticker_id"
    t.integer  "units"
    t.integer  "etf_holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "executed_at"
    t.decimal  "roi",                :precision => 15, :scale => 2
    t.decimal  "investment",         :precision => 15, :scale => 2
    t.decimal  "price",              :precision => 9,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
  end

  create_table "etf_holdings", :force => true do |t|
    t.integer  "etf_ticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "starting_units"
    t.decimal  "starting_price",      :precision => 9,  :scale => 2
    t.decimal  "starting_investment", :precision => 15, :scale => 2
    t.datetime "purchased_at"
    t.integer  "net_units"
    t.decimal  "net_investment",      :precision => 15, :scale => 2
    t.decimal  "net_return",          :precision => 15, :scale => 2
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y5_value"
    t.float    "y5_gain"
  end

  create_table "etf_ticker_eods", :force => true do |t|
    t.integer  "etf_ticker_id"
    t.decimal  "close",         :precision => 9, :scale => 2
    t.decimal  "high",          :precision => 9, :scale => 2
    t.decimal  "low",           :precision => 9, :scale => 2
    t.decimal  "open",          :precision => 9, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_on"
  end

  create_table "etf_tickers", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_events", :force => true do |t|
    t.integer  "fund_ticker_id"
    t.integer  "units"
    t.integer  "fund_holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "executed_at"
    t.decimal  "roi",                :precision => 15, :scale => 2
    t.decimal  "investment",         :precision => 15, :scale => 2
    t.decimal  "price",              :precision => 9,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
  end

  create_table "fund_holdings", :force => true do |t|
    t.integer  "fund_ticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "starting_units"
    t.decimal  "starting_price",      :precision => 9,  :scale => 2
    t.decimal  "starting_investment", :precision => 15, :scale => 2
    t.datetime "purchased_at"
    t.integer  "net_units"
    t.decimal  "net_investment",      :precision => 15, :scale => 2
    t.decimal  "net_return",          :precision => 15, :scale => 2
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y5_value"
    t.float    "y5_gain"
  end

  create_table "fund_ticker_eods", :force => true do |t|
    t.integer  "fund_ticker_id"
    t.decimal  "close",          :precision => 9, :scale => 2
    t.decimal  "high",           :precision => 9, :scale => 2
    t.decimal  "low",            :precision => 9, :scale => 2
    t.decimal  "open",           :precision => 9, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_on"
  end

  create_table "fund_tickers", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_portfolios", :force => true do |t|
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "founder_group_id"
    t.string   "type"
    t.string   "state"
    t.decimal  "investment",       :precision => 15, :scale => 2
    t.decimal  "ownership",        :precision => 5,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
    t.boolean  "lead",                                            :default => false
    t.string   "name"
  end

  create_table "multi_holding_allocations", :force => true do |t|
    t.integer  "multi_holding_id"
    t.integer  "fund_ticker_id"
    t.decimal  "allocation_percentage", :precision => 5, :scale => 2
    t.integer  "estimated_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
  end

  create_table "multi_holdings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.decimal  "net_investment", :precision => 15, :scale => 2
    t.decimal  "net_return",     :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
  end

  create_table "multi_statement_allocations", :force => true do |t|
    t.integer  "multi_statement_id"
    t.integer  "fund_ticker_id"
    t.decimal  "allocation_percentage", :precision => 5,  :scale => 2
    t.decimal  "contributions",         :precision => 9,  :scale => 2
    t.decimal  "distributions",         :precision => 15, :scale => 2
    t.integer  "estimated_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
  end

  create_table "multi_statements", :force => true do |t|
    t.integer  "multi_holding_id"
    t.date     "started_on"
    t.date     "ended_on"
    t.decimal  "starting_balance", :precision => 15, :scale => 2
    t.decimal  "ending_balance",   :precision => 15, :scale => 2
    t.decimal  "contributions",    :precision => 9,  :scale => 2
    t.decimal  "distributions",    :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
  end

  create_table "portfolio_plans", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolio_strategies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trust_level"
    t.string   "current_state"
    t.string   "portfolio_plan_id"
    t.string   "portfolio_strategy_id"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d7_plan_rank"
    t.float    "d7_strategy_rank"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d30_plan_rank"
    t.float    "d30_strategy_rank"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d180_plan_rank"
    t.float    "d180_strategy_rank"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "d365_plan_rank"
    t.float    "d365_strategy_rank"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y2_plan_rank"
    t.float    "y2_strategy_rank"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y3_plan_rank"
    t.float    "y3_strategy_rank"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y4_plan_rank"
    t.float    "y4_strategy_rank"
    t.float    "y5_value"
    t.float    "y5_gain"
    t.float    "y5_plan_rank"
    t.float    "y5_strategy_rank"
  end

  create_table "stock_events", :force => true do |t|
    t.integer  "stock_ticker_id"
    t.integer  "shares"
    t.integer  "stock_holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "executed_at"
    t.decimal  "roi",                :precision => 15, :scale => 2
    t.decimal  "investment",         :precision => 15, :scale => 2
    t.decimal  "price",              :precision => 9,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
  end

  create_table "stock_holdings", :force => true do |t|
    t.integer  "stock_ticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "starting_shares"
    t.decimal  "starting_price",      :precision => 9,  :scale => 2
    t.decimal  "starting_investment", :precision => 15, :scale => 2
    t.datetime "purchased_at"
    t.integer  "net_shares"
    t.decimal  "net_investment",      :precision => 15, :scale => 2
    t.decimal  "net_return",          :precision => 15, :scale => 2
    t.integer  "dow_index_eod_id"
    t.integer  "sp500_index_eod_id"
    t.integer  "tbill_index_eod_id"
    t.string   "current_state"
    t.float    "d7_value"
    t.float    "d7_gain"
    t.float    "d30_value"
    t.float    "d30_gain"
    t.float    "d180_value"
    t.float    "d180_gain"
    t.float    "d365_value"
    t.float    "d365_gain"
    t.float    "y2_value"
    t.float    "y2_gain"
    t.float    "y3_value"
    t.float    "y3_gain"
    t.float    "y4_value"
    t.float    "y4_gain"
    t.float    "y5_value"
    t.float    "y5_gain"
  end

  create_table "stock_ticker_eods", :force => true do |t|
    t.integer  "stock_ticker_id"
    t.decimal  "close",           :precision => 9, :scale => 2
    t.decimal  "high",            :precision => 9, :scale => 2
    t.decimal  "low",             :precision => 9, :scale => 2
    t.decimal  "open",            :precision => 9, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_on"
  end

  create_table "stock_tickers", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "image_url"
    t.string   "location"
    t.text     "description"
    t.text     "urls"
    t.string   "name"
    t.string   "current_state"
  end

end
