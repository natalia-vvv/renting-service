# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_128_101_205) do
  create_table 'bookings', force: :cascade do |t|
    t.date 'start_date'
    t.date 'end_date'
    t.integer 'client_id', null: false
    t.integer 'item_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['client_id'], name: 'index_bookings_on_client_id'
    t.index ['item_id'], name: 'index_bookings_on_item_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'filters', force: :cascade do |t|
    t.string 'name'
    t.integer 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_filters_on_category_id'
  end

  create_table 'item_options', id: false, force: :cascade do |t|
    t.integer 'item_id', null: false
    t.integer 'option_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_item_options_on_item_id'
    t.index ['option_id'], name: 'index_item_options_on_option_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.integer 'daily_price'
    t.integer 'owner_id', null: false
    t.integer 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_items_on_category_id'
    t.index ['owner_id'], name: 'index_items_on_owner_id'
  end

  create_table 'options', force: :cascade do |t|
    t.string 'value'
    t.integer 'filter_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['filter_id'], name: 'index_options_on_filter_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.string 'message'
    t.integer 'reviewer_id', null: false
    t.string 'reviewable_type'
    t.integer 'reviewable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[reviewable_type reviewable_id], name: 'index_reviews_on_reviewable'
    t.index ['reviewer_id'], name: 'index_reviews_on_reviewer_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'city_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_users_on_city_id'
  end

  add_foreign_key 'bookings', 'items'
  add_foreign_key 'bookings', 'users', column: 'client_id'
  add_foreign_key 'filters', 'categories'
  add_foreign_key 'item_options', 'items'
  add_foreign_key 'item_options', 'options'
  add_foreign_key 'items', 'categories'
  add_foreign_key 'items', 'users', column: 'owner_id'
  add_foreign_key 'options', 'filters'
  add_foreign_key 'reviews', 'users', column: 'reviewer_id'
  add_foreign_key 'users', 'cities'
end
