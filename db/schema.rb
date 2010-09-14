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

ActiveRecord::Schema.define(:version => 20100814182947) do

  create_table "descriptions", :force => true do |t|
    t.integer  "gift_id"
    t.text     "description"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donors", :force => true do |t|
    t.integer  "gift_id"
    t.integer  "allow_id"
    t.boolean  "marker_cb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gifts", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.integer  "registry_id"
    t.string   "name",                                  :null => false
    t.string   "source"
    t.string   "description",        :default => "",    :null => false
    t.string   "URL",                :default => "",    :null => false
    t.boolean  "i_can_see",          :default => true,  :null => false
    t.boolean  "friends_can_see",    :default => false, :null => false
    t.text     "who_can_see",                           :null => false
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
    t.integer  "user_id",                                   :null => false
    t.string   "name",        :default => "",               :null => false
    t.string   "description", :default => "",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sources", :force => true do |t|
    t.integer  "gift_id"
    t.integer  "user_id"
    t.boolean  "claim_cb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.text     "friends",                              :null => false
    t.string   "role_id"
    t.string   "username",          :default => "",    :null => false
    t.string   "email",             :default => "",    :null => false
    t.boolean  "terms_accepted_cb", :default => false, :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "viewers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "gift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
