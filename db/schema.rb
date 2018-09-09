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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_07_083719) do

  create_table "audit_corporations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_audit_corporations_on_name", unique: true
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "establishment_date"
    t.string "president_name"
    t.string "home_page"
    t.string "address"
    t.text "business_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_audit_corporations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "audit_corporation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audit_corporation_id"], name: "index_company_audit_corporations_on_audit_corporation_id"
    t.index ["company_id", "audit_corporation_id"], name: "unique_company_id_audit_corporation_id", unique: true
    t.index ["company_id"], name: "index_company_audit_corporations_on_company_id"
  end

  create_table "ipo_infomations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "code", null: false
    t.datetime "listing_date", null: false
    t.integer "public_shares"
    t.integer "sold_shares"
    t.integer "winning_shares"
    t.integer "provisional_condition_start"
    t.integer "provisional_condition_end"
    t.integer "public_offering_price"
    t.datetime "lottery_period_start"
    t.datetime "lottery_period_end"
    t.datetime "purchase_period_start"
    t.datetime "purchase_period_end"
    t.integer "initial_price"
    t.decimal "r_f_rate", precision: 4, scale: 2
    t.integer "trading_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ipo_infomations_on_company_id"
  end

  create_table "ipo_information_markets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ipo_infomation_id"
    t.bigint "market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ipo_infomation_id"], name: "index_ipo_information_markets_on_ipo_infomation_id"
    t.index ["market_id"], name: "index_ipo_information_markets_on_market_id"
  end

  create_table "markets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_markets_on_name", unique: true
  end

  create_table "secretaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "securities_company_id"
    t.decimal "rate", precision: 4, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "securities_company_id"], name: "unique_company_id_securities_company_id", unique: true
    t.index ["company_id"], name: "index_secretaries_on_company_id"
    t.index ["securities_company_id"], name: "index_secretaries_on_securities_company_id"
  end

  create_table "securities_companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_securities_companies_on_name", unique: true
  end

  create_table "shareholders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name", null: false
    t.decimal "rate", precision: 4, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_shareholders_on_company_id"
  end

  add_foreign_key "company_audit_corporations", "audit_corporations"
  add_foreign_key "company_audit_corporations", "companies"
  add_foreign_key "ipo_infomations", "companies"
  add_foreign_key "ipo_information_markets", "ipo_infomations"
  add_foreign_key "ipo_information_markets", "markets"
  add_foreign_key "secretaries", "companies"
  add_foreign_key "secretaries", "securities_companies"
  add_foreign_key "shareholders", "companies"
end
