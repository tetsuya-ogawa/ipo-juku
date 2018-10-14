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

ActiveRecord::Schema.define(version: 2018_10_14_053130) do

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "body", null: false
    t.boolean "is_published", default: true, null: false
    t.string "main_image"
    t.string "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audit_corporations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_audit_corporations_on_name", unique: true
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.date "establishment_date"
    t.string "president_name"
    t.string "home_page"
    t.string "address"
    t.string "code", null: false
    t.text "business_content"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_companies_on_industry_id"
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

  create_table "company_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.date "period", null: false
    t.integer "kind"
    t.integer "amount_of_sales"
    t.integer "ordinary_income"
    t.integer "profit"
    t.integer "asset"
    t.decimal "profit_per_stock", precision: 8, scale: 2
    t.decimal "asset_per_stock", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_sales_on_company_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_industries_on_name", unique: true
  end

  create_table "ipo_informations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "market_id"
    t.date "listing_date", null: false
    t.integer "public_shares"
    t.integer "sold_shares"
    t.integer "winning_shares"
    t.integer "provisional_condition_start"
    t.integer "provisional_condition_end"
    t.integer "public_offering_price"
    t.date "lottery_period_start"
    t.date "lottery_period_end"
    t.date "winning_date"
    t.date "purchase_period_start"
    t.date "purchase_period_end"
    t.integer "initial_price"
    t.decimal "r_f_rate", precision: 6, scale: 2
    t.integer "trading_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ipo_informations_on_company_id"
    t.index ["market_id"], name: "index_ipo_informations_on_market_id"
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
    t.decimal "rate", precision: 4, scale: 2
    t.boolean "is_main?", default: false, null: false
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

  add_foreign_key "companies", "industries"
  add_foreign_key "company_audit_corporations", "audit_corporations"
  add_foreign_key "company_audit_corporations", "companies"
  add_foreign_key "company_sales", "companies"
  add_foreign_key "ipo_informations", "companies"
  add_foreign_key "ipo_informations", "markets"
  add_foreign_key "secretaries", "companies"
  add_foreign_key "secretaries", "securities_companies"
  add_foreign_key "shareholders", "companies"
end
