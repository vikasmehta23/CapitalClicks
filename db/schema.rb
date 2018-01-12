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

ActiveRecord::Schema.define(version: 20180112180625) do

  create_table "exports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "purchase_id"
    t.string "NAME_OF_GOODS_SERVICES"
    t.string "HSNC_ACS"
    t.string "UQM"
    t.string "QTY"
    t.string "RATE_P_U"
    t.string "AMOUNT"
    t.string "LESS_DISCOUNT_ABATEMENT"
    t.string "TAXABLE_AMOUNT"
    t.string "CGST_RATE_OF_TAX"
    t.string "CGST_AMT"
    t.string "SGST_RATE_OF_TAX"
    t.string "SGST_AMT"
    t.string "IGST_RATE_OF_TAX"
    t.string "IGST_AMT"
    t.string "TOTAL_AMOUNT"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_exports_on_purchase_id"
  end

  create_table "exportsales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "sale_id"
    t.string "NAME_OF_GOODS_SERVICES"
    t.string "HSNC_ACS"
    t.string "UQM"
    t.string "QTY"
    t.string "RATE_P_U"
    t.string "AMOUNT"
    t.string "LESS_DISCOUNT_ABATEMENT"
    t.string "TAXABLE_AMOUNT"
    t.string "CGST_RATE_OF_TAX"
    t.string "CGST_AMT"
    t.string "SGST_RATE_OF_TAX"
    t.string "SGST_AMT"
    t.string "IGST_RATE_OF_TAX"
    t.string "IGST_AMT"
    t.string "TOTAL_AMOUNT"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_exportsales_on_sale_id"
  end

  create_table "purchases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "GSTIN_UIN"
    t.string "EMAIL_ID"
    t.string "CIN"
    t.string "TELEPHONE_NO"
    t.string "PAN"
    t.string "FAX"
    t.string "REVERSE_CHARGE"
    t.string "TRANSPORTATION_MODE"
    t.string "INVOICE_NO"
    t.string "VEHICLE_NO"
    t.datetime "INVOICE_DATE"
    t.datetime "DATE_OF_SUPPLY"
    t.string "STATE"
    t.string "PLACE_OF_SUPPLY"
    t.string "STATE_CODE"
    t.string "BUYER_NAME"
    t.string "BUYER_ADDRESS"
    t.string "BUYER_GSTIN_UIN"
    t.string "BUYER_CIN"
    t.string "BUYER_STATE"
    t.string "BUYER_STATE_CODE"
    t.string "CONSIGNEE_NAME"
    t.string "CONSIGNEE_ADDRESS"
    t.string "CONSIGNEE_GSTIN_UIN"
    t.string "CONSIGNEE_CIN"
    t.string "CONSIGNEE_STATE"
    t.string "CONSIGNEE_STATE_CODE"
    t.string "APPLICATION_NO_FOR_REMOVAL_OF_GOODS"
    t.datetime "APPLICATION_DATE_FOR_REMOVAL_OF_GOODS"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.bigint "user_id"
    t.string "comment"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "GSTIN_UIN"
    t.string "EMAIL_ID"
    t.string "CIN"
    t.string "TELEPHONE_NO"
    t.string "PAN"
    t.string "FAX"
    t.string "REVERSE_CHARGE"
    t.string "TRANSPORTATION_MODE"
    t.string "INVOICE_NO"
    t.string "VEHICLE_NO"
    t.datetime "INVOICE_DATE"
    t.datetime "DATE_OF_SUPPLY"
    t.string "STATE"
    t.string "PLACE_OF_SUPPLY"
    t.string "STATE_CODE"
    t.string "BUYER_NAME"
    t.string "BUYER_ADDRESS"
    t.string "BUYER_GSTIN_UIN"
    t.string "BUYER_CIN"
    t.string "BUYER_STATE"
    t.string "BUYER_STATE_CODE"
    t.string "CONSIGNEE_NAME"
    t.string "CONSIGNEE_ADDRESS"
    t.string "CONSIGNEE_GSTIN_UIN"
    t.string "CONSIGNEE_CIN"
    t.string "CONSIGNEE_STATE"
    t.string "CONSIGNEE_STATE_CODE"
    t.string "APPLICATION_NO_FOR_REMOVAL_OF_GOODS"
    t.datetime "APPLICATION_DATE_FOR_REMOVAL_OF_GOODS"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.bigint "user_id"
    t.string "comment"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "tax_invoice", primary_key: "tax_invoice_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "GSTIN_UIN", limit: 45, null: false
    t.string "EMAIL_ID", limit: 45, null: false
    t.string "CIN", limit: 45, null: false
    t.string "TELEPHONE_NO", limit: 45, null: false
    t.string "PAN", limit: 45, null: false
    t.string "FAX", limit: 45
    t.string "REVERSE_CHARGE", limit: 45, null: false
    t.string "TRANSPORTATION_MODE", limit: 45, default: "N.A."
    t.string "INVOICE_NO", limit: 45, null: false
    t.string "VEHICLE_NO", limit: 45, default: "N.A."
    t.timestamp "INVOICE_DATE", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "DATE_OF_SUPPLY"
    t.string "STATE", limit: 45, null: false
    t.string "PLACE_OF_SUPPLY", limit: 45, null: false
    t.string "STATE_CODE", limit: 45, null: false
    t.string "BUYER_NAME", limit: 45, null: false
    t.string "BUYER_ADDRESS", limit: 150, null: false
    t.string "BUYER_GSTIN_UIN", limit: 45, null: false
    t.string "BUYER_CIN", limit: 45
    t.string "BUYER_STATE", limit: 45, null: false
    t.string "BUYER_STATE_CODE", limit: 45, null: false
    t.string "CONSIGNEE_NAME", limit: 45, null: false
    t.string "CONSIGNEE_ADDRESS", limit: 150, null: false
    t.string "CONSIGNEE_GSTIN_UIN", limit: 45, null: false
    t.string "CONSIGNEE_CIN", limit: 45
    t.string "CONSIGNEE_STATE", limit: 45, null: false
    t.string "CONSIGNEE_STATE_CODE", limit: 45, null: false
    t.string "APPLICATION_NO_FOR_REMOVAL_OF_GOODS", limit: 45
    t.timestamp "APPLICATION_DATE_FOR_REMOVAL_OF_GOODS"
    t.index ["tax_invoice_id"], name: "tax_invoice_id_UNIQUE", unique: true
  end

  create_table "tax_invoice_sub_data", primary_key: ["tax_invoice_id", "tax_invoice_sub_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "tax_invoice_id", null: false
    t.bigint "tax_invoice_sub_id", null: false
    t.string "NAME_OF_GOODS_SERVICES", limit: 45, null: false
    t.string "HSNC_ACS", limit: 45, null: false
    t.string "UQM", limit: 45
    t.string "QTY", limit: 45, null: false
    t.string "RATE_P_U", limit: 45, null: false
    t.string "AMOUNT", limit: 45, null: false
    t.string "LESS_DISCOUNT_ABATEMENT", limit: 45
    t.string "TAXABLE_AMOUNT", limit: 45, null: false
    t.string "CGST_RATE_OF_TAX", limit: 45, null: false
    t.string "CGST_AMT", limit: 45, null: false
    t.string "SGST_RATE_OF_TAX", limit: 45, null: false
    t.string "SGST_AMT", limit: 45, null: false
    t.string "IGST_RATE_OF_TAX", limit: 45
    t.string "IGST_AMT", limit: 45
    t.string "TOTAL_AMOUNT", limit: 45, null: false
    t.timestamp "insert_timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email"
    t.string "password_hash"
    t.string "password_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.string "address"
    t.string "gst"
    t.string "phone"
    t.string "bankname"
    t.string "branchcode"
    t.string "accountnumber"
    t.string "ifsccode"
    t.string "pan"
    t.string "cin"
  end

  add_foreign_key "exports", "purchases"
  add_foreign_key "exportsales", "sales"
  add_foreign_key "purchases", "users"
  add_foreign_key "sales", "users"
end
