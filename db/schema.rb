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

ActiveRecord::Schema.define(version: 2021_11_23_103921) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "age_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coffee_beans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coffee_shop_coffee_beans", force: :cascade do |t|
    t.integer "coffee_shop_id"
    t.integer "coffee_bean_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coffee_shop_search_categories", force: :cascade do |t|
    t.integer "coffee_shop_id"
    t.integer "search_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coffee_shop_shop_atmospheres", force: :cascade do |t|
    t.integer "coffee_shop_id"
    t.integer "shop_atmosphere_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coffee_shops", force: :cascade do |t|
    t.string "name"
    t.string "shop_url"
    t.string "address"
    t.integer "tell"
    t.string "access"
    t.time "business_start_hour"
    t.time "business_end_hour"
    t.string "regular_holiday"
    t.string "instagram_url"
    t.string "instagram_spot_url"
    t.integer "municipalitie_id"
    t.string "first_image_url"
    t.string "second_image_url"
    t.string "third_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likees_count", default: 0
    t.integer "likers_count", default: 0
    t.time "slack_time_start"
    t.time "slack_time_end"
    t.string "age_group"
  end

  create_table "day_of_weeks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string "follower_type"
    t.integer "follower_id"
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "likes", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.integer "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coffee_shop_id"
    t.text "review_comment"
    t.string "review_pictuer"
    t.integer "review_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coffee_shop_id"], name: "index_reviews_on_coffee_shop_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "search_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_atmospheres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "age"
    t.string "gender"
    t.string "self_introduction"
    t.string "image"
    t.string "instagram_url"
    t.boolean "deleted_flg", default: false, null: false
    t.string "authority"
    t.integer "followers_count", default: 0
    t.integer "best_shop_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
