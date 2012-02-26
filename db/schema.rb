# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20110616061647) do

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "courseware_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits_count",        :default => 0
  end

  add_index "assets", ["courseware_id"], :name => "index_assets_on_courseware_id"

  create_table "courses", :force => true do |t|
    t.integer  "institute_id"
    t.string   "number"
    t.string   "name"
    t.string   "pinyin"
    t.string   "eng_name"
    t.string   "ben_yan"
    t.float    "credit"
    t.float    "credit_hours"
    t.string   "jiaoxuefs"
    t.text     "neirongjianjie"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "book1"
    t.string   "book2"
    t.integer  "teachings_count",   :default => 0, :null => false
    t.integer  "coursewares_count", :default => 0, :null => false
    t.integer  "favorites_count",   :default => 0, :null => false
    t.string   "qcache1"
    t.string   "qcache2"
    t.text     "memo"
  end

  create_table "coursewares", :force => true do |t|
    t.float    "price",           :default => 0.0
    t.integer  "course_id",                        :null => false
    t.integer  "user_id"
    t.integer  "teacher_id"
    t.string   "semester"
    t.string   "title"
    t.string   "klass"
    t.text     "description"
    t.integer  "hit_count",       :default => 0
    t.integer  "purchases_count", :default => 0
    t.integer  "assets_count",    :default => 0
    t.integer  "replies_count",   :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quintessence",    :default => 0,   :null => false
    t.boolean  "hidden"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "newness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
  end

  create_table "institutes", :force => true do |t|
    t.string   "icon",       :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "courseware_id",                    :null => false
    t.float    "amount",                           :null => false
    t.boolean  "overdrawn",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", :force => true do |t|
    t.integer  "courseware_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.integer  "institute_id"
    t.string   "name"
    t.string   "pinyin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coursewares_count", :default => 0, :null => false
    t.integer  "teachings_count",   :default => 0, :null => false
  end

  create_table "teachings", :force => true do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.boolean  "is_admin",                            :default => false,    :null => false
    t.string   "email",                               :default => ""
    t.string   "encrypted_password",   :limit => 128, :default => "",       :null => false
    t.string   "password_salt",                       :default => "",       :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "last_seen"
    t.string   "number",                                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",                               :default => 0,        :null => false
    t.string   "avatar",                              :default => "01.gif", :null => false
    t.string   "nickname"
    t.float    "credit",                              :default => 0.0,      :null => false
    t.integer  "purchases_count",                     :default => 0,        :null => false
    t.integer  "institute_id",                        :default => 0,        :null => false
    t.integer  "coursewares_count",                   :default => 0,        :null => false
    t.string   "md5pass"
    t.integer  "favorites_count",                     :default => 0,        :null => false
    t.integer  "identified",                          :default => 0,        :null => false
    t.text     "memo"
    t.string   "xm"
    t.string   "sfzh"
    t.string   "xb"
    t.string   "xslb"
    t.string   "mz"
    t.string   "jg"
    t.string   "csrq"
    t.string   "zzmm"
    t.string   "kq"
    t.string   "byzx"
    t.string   "gkzf"
    t.string   "rxrq"
    t.string   "zy"
    t.string   "nj"
    t.string   "bj"
    t.string   "xq"
    t.string   "pyfs"
    t.boolean  "xiaowai",                             :default => false
    t.integer  "corenum",                             :default => 0,        :null => false
  end

  add_index "users", ["number"], :name => "index_users_on_number", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
