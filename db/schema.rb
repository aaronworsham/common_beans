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

ActiveRecord::Schema.define(:version => 20111221024513) do

  create_table "buys", :force => true do |t|
    t.integer  "ticker_id"
    t.integer  "holding_id"
    t.integer  "user_id"
    t.integer  "shares"
    t.decimal  "price",         :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "investment",    :precision => 15, :scale => 2
    t.datetime "date_of_event"
  end

  create_table "club_memberships", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dow_index_eods", :force => true do |t|
    t.decimal  "close",      :precision => 8, :scale => 2
    t.float    "net_change"
    t.date     "closed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "ticker_id"
    t.integer  "shares"
    t.integer  "holding_id"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "date_of_event"
    t.decimal  "return_on_investment"
    t.decimal  "investment",           :precision => 15, :scale => 2
    t.decimal  "price",                :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dow_index_eod_id"
    t.string   "current_state"
  end

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_holdings", :force => true do |t|
    t.decimal  "starting_units"
    t.decimal  "starting_investment"
    t.decimal  "net_investment"
    t.decimal  "net_units"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "fund_ticker_id"
    t.string   "current_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_portfolios", :force => true do |t|
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "founder_group_id"
    t.string   "type"
    t.string   "state"
    t.decimal  "investment",       :precision => 9, :scale => 2
    t.float    "ownership"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
    t.boolean  "is_lead",                                        :default => false
    t.string   "name"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "index_eods", :force => true do |t|
    t.integer  "index_id"
    t.decimal  "close"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "open"
    t.date     "closed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indices", :force => true do |t|
    t.string   "symbol"
    t.string   "yahoo_symbol"
    t.string   "name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investment_spans", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "opening_balance"
    t.decimal  "closing_balance"
    t.decimal  "units"
    t.integer  "user_id"
    t.integer  "fund_holding_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_trust_level"
    t.string   "current_state"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sells", :force => true do |t|
    t.integer  "ticker_id"
    t.integer  "shares"
    t.integer  "holding_id"
    t.integer  "user_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "return_on_investment"
    t.datetime "date_of_event"
  end

# Could not dump table "stock_holdings" because of following StandardError
#   Unknown type 'stock_ticker_id' for column 'ticker_id'

  create_table "ticker_eods", :force => true do |t|
    t.integer  "ticker_id"
    t.decimal  "close"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_on"
  end

  create_table "tickers", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
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
