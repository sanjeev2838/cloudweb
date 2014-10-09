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

ActiveRecord::Schema.define(:version => 20141009114659) do

  create_table "child_brewing_preferences", :force => true do |t|
    t.integer  "temperature"
    t.integer  "milk"
    t.integer  "child_profile_id"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "brew_type"
    t.integer  "product_id"
  end

  create_table "child_parent_relationships", :force => true do |t|
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
    t.integer  "preference_id"
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
    t.datetime "datetime"
    t.integer  "parent_profile_id"
    t.integer  "child_profile_id"
    t.integer  "vaccine_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "diaries", :force => true do |t|
    t.string   "log"
    t.integer  "milestone_id"
    t.integer  "child_profile_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "diaries_milestones", :id => false, :force => true do |t|
    t.integer "diary_id"
    t.integer "milestone_id"
  end

  create_table "firmwares", :force => true do |t|
    t.string   "firmwareversion"
    t.string   "serialids"
    t.string   "binaryfile"
    t.boolean  "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "logbooks", :force => true do |t|
    t.string   "log"
    t.integer  "child_profile_id"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "machine_logs", :force => true do |t|
    t.integer  "data"
    t.integer  "machine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "machines", :force => true do |t|
    t.string   "serialid"
    t.string   "firmware"
    t.string   "hwconfig"
    t.string   "macaddress"
    t.string   "ipaddress"
    t.string   "bootloader"
    t.string   "color"
    t.boolean  "status"
    t.datetime "activated_on"
    t.string   "error_msg"
    t.string   "temp"
    t.string   "psu_voltage"
    t.string   "host_profile"
  end

  create_table "milestones", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "en"
    t.string   "no"
    t.string   "sv"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parent_profiles", :force => true do |t|
    t.integer  "devicetypeid"
    t.boolean  "is_machine_owner"
    t.string   "name"
    t.boolean  "status"
    t.string   "tokenid"
    t.string   "email"
    t.string   "password"
    t.string   "authtoken"
    t.string   "lang"
    t.integer  "relation"
    t.integer  "machine_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "pictures", :force => true do |t|
    t.string   "filepath"
    t.boolean  "status"
    t.string   "image"
    t.boolean  "profilepic"
    t.integer  "parent_profile_id"
    t.integer  "child_profile_id"
    t.integer  "log_id"
    t.integer  "diary_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "vendor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "brew_type"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "volume"
    t.integer  "key_32"
    t.integer  "key_33"
    t.integer  "key_34"
    t.integer  "key_35"
    t.integer  "key_36"
    t.integer  "key_37"
    t.integer  "key_38"
    t.integer  "key_39"
    t.integer  "key_40"
    t.integer  "key_41"
    t.integer  "key_42"
    t.integer  "key_43"
    t.integer  "key_44"
    t.integer  "key_45"
    t.integer  "key_46"
    t.integer  "key_47"
    t.integer  "key_48"
    t.integer  "key_49"
    t.integer  "key_50"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "ip_address"
    t.datetime "last_login"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "vaccine_ages", :force => true do |t|
    t.integer  "age"
    t.integer  "vaccine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vaccine_languages", :force => true do |t|
    t.string   "title"
    t.string   "locale"
    t.integer  "vaccine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vaccines", :force => true do |t|
    t.string   "age"
    t.string   "year_courses"
    t.string   "vaccination_against"
    t.string   "title"
    t.string   "number_of_doses"
    t.string   "locale"
    t.boolean  "status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "en"
    t.string   "sv"
    t.string   "no"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
