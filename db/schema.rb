# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_26_025756) do

  create_table "armors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "first_colors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "part"
    t.integer "hue", default: 0, null: false
    t.integer "saturation", default: 0, null: false
    t.integer "value", default: 0, null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_first_colors_on_post_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "head_armor_id"
    t.bigint "body_armor_id"
    t.bigint "arm_armor_id"
    t.bigint "waist_armor_id"
    t.bigint "foot_armor_id"
    t.integer "character_gender", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["arm_armor_id"], name: "index_posts_on_arm_armor_id"
    t.index ["body_armor_id"], name: "index_posts_on_body_armor_id"
    t.index ["foot_armor_id"], name: "index_posts_on_foot_armor_id"
    t.index ["head_armor_id"], name: "index_posts_on_head_armor_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["waist_armor_id"], name: "index_posts_on_waist_armor_id"
  end

  create_table "second_colors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "part"
    t.integer "hue", default: 0, null: false
    t.integer "saturation", default: 0, null: false
    t.integer "value", default: 0, null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_second_colors_on_post_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "first_colors", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "second_colors", "posts"
end
