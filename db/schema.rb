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

ActiveRecord::Schema.define(:version => 20120712151722) do

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
    t.date     "points_updated_at"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_gain_ratio"
    t.string   "cusip"
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
    t.date     "points_updated_at"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_gain_ratio"
    t.string   "cusip"
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
    t.date     "points_updated_at"
    t.float    "d5_price"
    t.float    "d5_price_gain"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_price"
    t.float    "d30_price_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d90_price"
    t.float    "d90_price_gain"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_price"
    t.float    "d180_price_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_price"
    t.float    "y1_price_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_price"
    t.float    "y2_price_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_price"
    t.float    "y3_price_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_price"
    t.float    "y4_price_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_price"
    t.float    "y5_price_gain"
    t.float    "y5_gain_ratio"
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

  create_table "financial_advice", :force => true do |t|
    t.integer  "user_id"
    t.integer  "financial_adviser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financial_adviser_invites", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "email"
    t.string   "passcode"
    t.string   "salt"
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
    t.date     "points_updated_at"
    t.float    "d5_price"
    t.float    "d5_price_gain"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_price"
    t.float    "d30_price_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d90_price"
    t.float    "d90_price_gain"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_price"
    t.float    "d180_price_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_price"
    t.float    "y1_price_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_price"
    t.float    "y2_price_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_price"
    t.float    "y3_price_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_price"
    t.float    "y4_price_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_price"
    t.float    "y5_price_gain"
    t.float    "y5_gain_ratio"
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
    t.string   "category"
    t.string   "family"
    t.string   "inception_date"
    t.text     "summary"
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

  create_table "index_eods", :force => true do |t|
    t.integer  "security_index_id"
    t.decimal  "close",             :precision => 9, :scale => 2
    t.decimal  "high",              :precision => 9, :scale => 2
    t.decimal  "low",               :precision => 9, :scale => 2
    t.decimal  "open",              :precision => 9, :scale => 2
    t.date     "closed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investment_advisor_firms", :force => true do |t|
    t.integer  "crd_number"
    t.string   "sec_number"
    t.string   "name"
    t.string   "legal_name"
    t.integer  "main_office_loc_id"
    t.string   "current_status"
    t.date     "status_eff_date"
    t.date     "last_adv_filing_date"
    t.string   "url"
    t.boolean  "assets_gt_1b"
    t.boolean  "sec_reg_large_advisory_firm"
    t.boolean  "sec_reg_mid_advisory_firm"
    t.boolean  "sec_reg_main_office_in_wy"
    t.boolean  "sec_reg_main_office_outside_us"
    t.boolean  "sec_reg_adviser_to_investment_co"
    t.boolean  "sec_reg_adviser_to_biz_dev_co"
    t.boolean  "sec_reg_pension_consultant"
    t.boolean  "sec_reg_newly_formed"
    t.boolean  "sec_reg_multi_state"
    t.boolean  "sec_reg_internet_adviser"
    t.boolean  "sec_reg_no_longer_sec_eligible"
    t.string   "organization"
    t.string   "organization_other"
    t.string   "org_state"
    t.string   "org_country"
    t.integer  "num_employees"
    t.integer  "num_advisers"
    t.integer  "num_broker_dealer_reps"
    t.integer  "num_iars"
    t.integer  "num_iars_for_other_company"
    t.integer  "num_insurance_agents"
    t.integer  "num_solicit_clients"
    t.string   "num_clients"
    t.integer  "num_clients_more_than_100"
    t.integer  "percent_clients_non_us"
    t.string   "percent_clients_individuals"
    t.string   "percent_clients_high_net_worth_individuals"
    t.string   "percent_clients_banking_or_thrifts"
    t.string   "percent_clients_investment_comps"
    t.string   "percent_clients_biz_dev_comps"
    t.string   "percent_clients_pooled_invest_vehicles"
    t.string   "percent_clients_pension_plans"
    t.string   "percent_clients_charities"
    t.string   "percent_clients_non_listed_comps"
    t.string   "percent_clients_state_or_muni_govs"
    t.string   "percent_clients_other_invest_advisers"
    t.string   "percent_clients_other_insurance_comps"
    t.string   "percent_clients_other"
    t.boolean  "comp_percent_assets"
    t.boolean  "comp_hourly_rate"
    t.boolean  "comp_sub_fee"
    t.boolean  "comp_fixed_fee"
    t.boolean  "comp_commission"
    t.boolean  "comp_perf_fee"
    t.string   "comp_other"
    t.boolean  "manage_portfolios"
    t.integer  "amount_under_management_desc"
    t.integer  "accounts_under_management_desc"
    t.integer  "amount_under_management_non_desc"
    t.integer  "accounts_under_management_non_desc"
    t.integer  "amount_under_management_total"
    t.integer  "accounts_under_management_total"
    t.boolean  "service_financial_planning"
    t.boolean  "service_ind_portfolio_management"
    t.boolean  "service_inv_comp_portfolio_management"
    t.boolean  "service_pooled_inv_portfolio_management"
    t.boolean  "service_inst_client_portfolio_management"
    t.boolean  "service_pension_consulting"
    t.boolean  "service_select_advisers"
    t.boolean  "service_publication"
    t.boolean  "service_security_rating"
    t.boolean  "service_market_timing"
    t.boolean  "service_education"
    t.string   "service_other"
    t.string   "service_ind_portfolio_management_num_clients"
    t.boolean  "activity_broker_dealer"
    t.boolean  "activity_reg_rep_broker_dealer"
    t.boolean  "activity_commodity_trading"
    t.boolean  "activity_futures_commission"
    t.boolean  "activity_real_estate"
    t.boolean  "activity_insurance"
    t.boolean  "activity_bank"
    t.boolean  "activity_trust"
    t.boolean  "activity_muni_adviser"
    t.boolean  "activity_security_swap_dealer"
    t.boolean  "activity_security_swap_participant"
    t.boolean  "activity_accountant"
    t.boolean  "activity_law"
    t.string   "activity_other"
    t.boolean  "custody_cash"
    t.boolean  "custody_securities"
    t.integer  "custody_total_amount"
    t.integer  "custody_total_clients"
    t.boolean  "custody_qualified_custodian"
    t.boolean  "custody_independent_audit"
    t.boolean  "custody_independent_examination"
    t.boolean  "custody_independent_control_report"
    t.boolean  "disc_felony_conviction"
    t.boolean  "disc_felony_charges"
    t.boolean  "disc_investment_misdemeanor_conviction"
    t.boolean  "disc_investment_misdemeanor_charges"
    t.boolean  "disc_sec_false_statement"
    t.boolean  "disc_sec_reg_violation"
    t.boolean  "disc_sec_cause_investment_auth_revoke"
    t.boolean  "disc_sec_investment_order"
    t.boolean  "disc_sec_civil_penalty"
    t.boolean  "disc_fed_false_statement"
    t.boolean  "disc_fed_reg_violation"
    t.boolean  "disc_fed_cause_investment_auth_revoke"
    t.boolean  "disc_fed_investment_order"
    t.boolean  "disc_fed_civil_penalty"
    t.boolean  "disc_org_false_statement"
    t.boolean  "disc_org_reg_violation"
    t.boolean  "disc_org_cause_investment_auth_revoke"
    t.boolean  "disc_org_investment_order"
    t.boolean  "disc_revoked_authority"
    t.boolean  "disc_current_proceedings"
    t.boolean  "disc_court_enjoined"
    t.boolean  "disc_court_reg_violations"
    t.boolean  "disc_court_civil_penalty"
    t.boolean  "disc_court_proceedings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_state"
    t.string   "address_city"
    t.string   "address_zip"
    t.string   "address_country"
    t.string   "phone"
    t.string   "fax"
    t.string   "mail_address_1"
    t.string   "mail_address_2"
    t.string   "mail_address_state"
    t.string   "mail_address_city"
    t.string   "mail_address_zip"
    t.string   "mail_address_country"
    t.string   "url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multi_holding_allocations", :force => true do |t|
    t.integer  "multi_holding_id"
    t.integer  "fund_ticker_id"
    t.decimal  "allocation_percentage",   :precision => 5,  :scale => 2
    t.integer  "estimated_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
    t.date     "allocated_on"
    t.decimal  "price_at_allocation",     :precision => 15, :scale => 2
    t.float    "est_units"
    t.float    "est_value_at_allocation"
  end

  create_table "multi_holdings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.decimal  "net_investment",    :precision => 15, :scale => 2
    t.decimal  "net_return",        :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
    t.string   "name"
    t.date     "points_updated_at"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_gain_ratio"
  end

  create_table "multi_statement_allocations", :force => true do |t|
    t.integer  "multi_statement_id"
    t.integer  "fund_ticker_id"
    t.decimal  "allocation_percentage",   :precision => 5,  :scale => 2
    t.decimal  "contributions",           :precision => 9,  :scale => 2
    t.decimal  "distributions",           :precision => 15, :scale => 2
    t.integer  "estimated_units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state"
    t.date     "allocated_on"
    t.decimal  "price_at_allocation",     :precision => 15, :scale => 2
    t.float    "est_units"
    t.float    "est_value_at_allocation"
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
    t.integer  "user_id"
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
    t.date     "points_updated_at"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d5_plan_rank"
    t.float    "d5_strategy_rank"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_gain_ratio"
    t.float    "d30_plan_rank"
    t.float    "d30_strategy_rank"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d90_plan_rank"
    t.float    "d90_strategy_rank"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_gain_ratio"
    t.float    "d180_plan_rank"
    t.float    "d180_strategy_rank"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_gain_ratio"
    t.float    "y1_plan_rank"
    t.float    "y1_strategy_rank"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_gain_ratio"
    t.float    "y2_plan_rank"
    t.float    "y2_strategy_rank"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_gain_ratio"
    t.float    "y3_plan_rank"
    t.float    "y3_strategy_rank"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_gain_ratio"
    t.float    "y4_plan_rank"
    t.float    "y4_strategy_rank"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_gain_ratio"
    t.float    "y5_plan_rank"
    t.float    "y5_strategy_rank"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "security_indices", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "points_updated_at"
    t.float    "d5_price"
    t.float    "d5_price_gain"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_price"
    t.float    "d30_price_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d90_price"
    t.float    "d90_price_gain"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_price"
    t.float    "d180_price_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_price"
    t.float    "y1_price_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_price"
    t.float    "y2_price_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_price"
    t.float    "y3_price_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_price"
    t.float    "y4_price_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_price"
    t.float    "y5_price_gain"
    t.float    "y5_gain_ratio"
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
    t.date     "points_updated_at"
    t.float    "d5_price"
    t.float    "d5_price_gain"
    t.float    "d5_value"
    t.float    "d5_value_gain"
    t.float    "d5_gain_ratio"
    t.float    "d30_value"
    t.float    "d30_value_gain"
    t.float    "d30_price"
    t.float    "d30_price_gain"
    t.float    "d30_gain_ratio"
    t.float    "d90_value"
    t.float    "d90_value_gain"
    t.float    "d90_gain_ratio"
    t.float    "d90_price"
    t.float    "d90_price_gain"
    t.float    "d180_value"
    t.float    "d180_value_gain"
    t.float    "d180_price"
    t.float    "d180_price_gain"
    t.float    "d180_gain_ratio"
    t.float    "y1_value"
    t.float    "y1_value_gain"
    t.float    "y1_price"
    t.float    "y1_price_gain"
    t.float    "y1_gain_ratio"
    t.float    "y2_value"
    t.float    "y2_value_gain"
    t.float    "y2_price"
    t.float    "y2_price_gain"
    t.float    "y2_gain_ratio"
    t.float    "y3_value"
    t.float    "y3_value_gain"
    t.float    "y3_price"
    t.float    "y3_price_gain"
    t.float    "y3_gain_ratio"
    t.float    "y4_value"
    t.float    "y4_value_gain"
    t.float    "y4_price"
    t.float    "y4_price_gain"
    t.float    "y4_gain_ratio"
    t.float    "y5_value"
    t.float    "y5_value_gain"
    t.float    "y5_price"
    t.float    "y5_price_gain"
    t.float    "y5_gain_ratio"
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
    t.text     "business_summary"
    t.string   "sector"
    t.string   "industry"
    t.string   "url"
  end

  create_table "user_invites", :force => true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "email"
    t.string   "passcode"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
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
    t.string   "last_login_version"
    t.string   "last_login_state"
    t.datetime "last_logged_in_at"
  end

end
