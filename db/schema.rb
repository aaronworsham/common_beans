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

ActiveRecord::Schema.define(:version => 20111101220252) do

  create_table "advisors", :force => true do |t|
    t.string   "crd_num"
    t.string   "sec_num"
    t.string   "name"
    t.string   "legal_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_postal"
    t.string   "phone"
    t.string   "fax"
    t.string   "url"
    t.string   "reg_status"
    t.datetime "reg_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holdings", :force => true do |t|
    t.integer  "ticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.integer  "starting_shares"
    t.decimal  "starting_price"
    t.decimal  "starting_investment"
    t.datetime "date_of_purchase"
    t.integer  "net_shares"
    t.decimal  "net_investment"
    t.decimal  "net_return"
    t.integer  "dow_index_eod_id"
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

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_trust_level"
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
  end

end
