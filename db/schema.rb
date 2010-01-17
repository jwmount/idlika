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

ActiveRecord::Schema.define(:version => 20100117001036) do

  create_table "gifts", :force => true do |t|
    t.integer  "giver_id"
    t.string   "name"
    t.string   "supplier"
    t.string   "description"
    t.text     "image"
    t.text     "tags"
    t.text     "audience"
    t.datetime "by_when"
    t.datetime "after_when"
    t.string   "for_my"
    t.datetime "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "givers", :force => true do |t|
    t.integer  "gift_id"
    t.string   "name"
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "cyrpted_password"
    t.string   "salt"
    t.string   "remember_token"
    t.string   "remember_token_expiration"
    t.string   "activation_code"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
