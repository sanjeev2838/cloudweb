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

ActiveRecord::Schema.define(:version => 20140211101609) do

  create_table "child_brewing_preferences", :force => true do |t|
    t.integer  "temperature"
    t.integer  "milk"
    t.integer  "child_profile_id"
    t.integer  "parent_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.string   "diary"
    t.integer  "child_profile_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "firmwares", :force => true do |t|
    t.string   "firmwareversion"
    t.string   "serialids"
    t.string   "binaryfile"
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
    t.string   "color"
    t.boolean  "status"
    t.datetime "activated_on"
  end

  create_table "milestone_translations", :force => true do |t|
    t.integer  "milestone_id", :null => false
    t.string   "locale",       :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
  end

  add_index "milestone_translations", ["locale"], :name => "index_milestone_translations_on_locale"
  add_index "milestone_translations", ["milestone_id"], :name => "index_milestone_translations_on_milestone_id"

  create_table "milestones", :force => true do |t|
    t.string   "title"
    t.string   "icon"
    t.string   "image"
    t.integer  "language_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "filepath"
    t.boolean  "status"
    t.string   "image"
    t.boolean  "profilepic"
    t.integer  "parent_profile_id"
    t.integer  "child_profile_id"
    t.integer  "diary_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "ip_address"
    t.datetime "last_login"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "vaccine_translations", :force => true do |t|
    t.integer  "vaccine_id",          :null => false
    t.string   "locale",              :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "title"
    t.string   "age"
    t.string   "year_courses"
    t.string   "vaccination_against"
    t.string   "number_of_doses"
  end

  add_index "vaccine_translations", ["locale"], :name => "index_vaccine_translations_on_locale"
  add_index "vaccine_translations", ["vaccine_id"], :name => "index_vaccine_translations_on_vaccine_id"

  create_table "vaccines", :force => true do |t|
    t.string   "age"
    t.string   "year_courses"
    t.string   "vaccination_against"
    t.string   "title"
    t.string   "number_of_doses"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
