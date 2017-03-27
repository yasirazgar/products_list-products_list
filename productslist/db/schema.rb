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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170323044955) do

  create_table "categories", force: true do |t|
    t.string "name"
  end

  create_table "products", force: true do |t|
    t.string   "sku_id",                         null: false
    t.string   "name"
    t.date     "expire_date"
    t.text     "images"
    t.integer  "price",          default: 0
    t.text     "description"
    t.boolean  "admin_approved", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products_categories", force: true do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  add_index "products_categories", ["category_id"], name: "index_products_categories_on_category_id", using: :btree
  add_index "products_categories", ["product_id"], name: "index_products_categories_on_product_id", using: :btree

  create_table "products_tags", force: true do |t|
    t.integer "product_id"
    t.integer "tag_id"
  end

  add_index "products_tags", ["product_id"], name: "index_products_tags_on_product_id", using: :btree
  add_index "products_tags", ["tag_id"], name: "index_products_tags_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

end
