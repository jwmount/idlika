# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100608164540) do

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "gift_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gifts", :force => true do |t|
    t.integer  "user_id",            :default => 0,     :null => false
    t.integer  "registry_id",        :default => 1,     :null => false
    t.string   "name"
    t.string   "source"
    t.string   "description"
    t.string   "URL"
    t.boolean  "none_can_see",       :default => true
    t.boolean  "anyone_can_see",     :default => false
    t.text     "who_can_see",                           :null => false
    t.datetime "deleted"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "gift_id"
    t.integer  "registry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registries", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "friend_id"
    t.string   "role_id"
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "terms_accepted_cb", :default => false, :null => false
    t.text     "friends"
  end

  create_table "viewers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "gift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
