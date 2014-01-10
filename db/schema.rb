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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131223102710) do

  create_table "child_brewing_preferences", :force => true do |t|
    t.integer  "temperature"
    t.integer  "milk"
    t.integer  "child_profile_id"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "child_profiles", :force => true do |t|
    t.string   "name"
    t.string   "dob"
    t.string   "gender"
    t.string   "status"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "child_stats", :force => true do |t|
    t.integer  "diapers"
    t.integer  "weight"
    t.integer  "height"
    t.string   "meals"
    t.integer  "bottle"
    t.integer  "parent_profile_id"
    t.integer  "child_profile_id"
    t.integer  "vaccine_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "logbooks", :force => true do |t|
    t.string   "log"
    t.integer  "child_profile_id"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "machine_logs", :force => true do |t|
    t.string   "data"
    t.integer  "machine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "machines", :force => true do |t|
    t.integer  "serialid"
    t.string   "firmware"
    t.string   "hwconfig"
    t.string   "macaddress"
    t.string   "ipaddress"
    t.string   "bootloader"
    t.boolean  "status"
    t.datetime "activated_on"
  end

  create_table "parent_profiles", :force => true do |t|
    t.integer  "deviceid"
    t.integer  "devicetypeid"
    t.boolean  "is_machine_owner"
    t.string   "name"
    t.boolean  "status"
    t.string   "imei"
    t.string   "tokenid"
    t.integer  "machine_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "filepath"
    t.boolean  "status"
    t.string   "image"
    t.integer  "parent_profile_id"
    t.integer  "child_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.integer  "role_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "authentication_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vaccines", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
