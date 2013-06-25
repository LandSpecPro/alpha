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

ActiveRecord::Schema.define(:version => 20130625165021) do

  create_table "bus_buyers", :force => true do |t|
    t.string   "busName",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "busType"
    t.string   "busPhone"
    t.string   "busFax"
    t.string   "busContact"
    t.string   "busEmail"
    t.string   "busWebsite"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "active",            :default => true,  :null => false
    t.text     "tagline"
    t.boolean  "verified",          :default => false, :null => false
  end

  create_table "bus_vendors", :force => true do |t|
    t.string   "busName",                              :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "user_id"
    t.string   "busType"
    t.string   "busPhone"
    t.string   "busFax"
    t.string   "busContact"
    t.string   "busEmail"
    t.string   "busWebsite"
    t.boolean  "active",            :default => true,  :null => false
    t.text     "tagline"
    t.boolean  "verified",          :default => false, :null => false
  end

  create_table "categories", :force => true do |t|
    t.string  "category"
    t.string  "parentCategory"
    t.boolean "active",         :default => true, :null => false
    t.integer "hierarchyLevel", :default => 0,    :null => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "location_id",                      :null => false
    t.string   "firstName",                        :null => false
    t.string   "lastName"
    t.string   "primaryPhone"
    t.string   "secondaryPhone"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "active",         :default => true, :null => false
  end

  create_table "fav_locations", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "location_id",                   :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",      :default => true, :null => false
  end

  create_table "fav_products", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "product_id",                         :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "featured_item_id"
    t.boolean  "active",           :default => true, :null => false
  end

  create_table "featured_items", :force => true do |t|
    t.integer  "location_id",                                                       :null => false
    t.integer  "product_id",                                                        :null => false
    t.integer  "product_image_id"
    t.text     "description"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.string   "size"
    t.decimal  "price",            :precision => 10, :scale => 2
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active",                                          :default => true, :null => false
  end

  create_table "location_has_categories", :force => true do |t|
    t.integer  "location_id"
    t.integer  "category_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",      :default => true, :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "bus_vendor_id",                     :null => false
    t.string   "locName"
    t.string   "primaryPhone"
    t.string   "secondaryPhone"
    t.string   "fax"
    t.string   "address1",                          :null => false
    t.string   "address2"
    t.string   "city",                              :null => false
    t.string   "state",                             :null => false
    t.string   "zip",                               :null => false
    t.string   "primaryEmail"
    t.string   "secondaryEmail"
    t.string   "websiteLink"
    t.string   "facebookLink"
    t.string   "twitterLink"
    t.string   "googleLink"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active",         :default => true,  :null => false
    t.string   "busName",                           :null => false
    t.boolean  "verified",       :default => false, :null => false
    t.text     "bio"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "category"
    t.string   "parentCategory"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "product_has_categories", :force => true do |t|
    t.integer  "featured_item_id"
    t.integer  "category_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "active",           :default => true, :null => false
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id",                            :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",             :default => true,  :null => false
    t.boolean  "verified",           :default => false, :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "commonName",                    :null => false
    t.string   "latinName"
    t.string   "altName"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",     :default => true,  :null => false
    t.boolean  "verified",   :default => false, :null => false
  end

  create_table "search_logs", :force => true do |t|
    t.string   "searchTerm"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "currentState"
    t.string   "currentCity"
    t.text     "categories"
    t.string   "distanceFrom"
    t.text     "searchType"
    t.boolean  "active",       :default => true, :null => false
  end

  create_table "statuses", :force => true do |t|
    t.text     "status"
    t.boolean  "active",      :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "location_id",                   :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "user_sessions_id", :null => false
    t.text     "data"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"
  add_index "user_sessions", ["user_sessions_id"], :name => "index_user_sessions_on_user_sessions_id"

  create_table "users", :force => true do |t|
    t.string   "login",                                          :null => false
    t.string   "email",                                          :null => false
    t.string   "userType",                  :default => "buyer", :null => false
    t.string   "crypted_password",                               :null => false
    t.string   "password_salt",                                  :null => false
    t.string   "persistence_token",                              :null => false
    t.integer  "login_count",               :default => 0,       :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "bus_vendor_id"
    t.integer  "bus_buyer_id"
    t.string   "profileImage_file_name"
    t.string   "profileImage_content_type"
    t.integer  "profileImage_file_size"
    t.datetime "profileImage_updated_at"
    t.string   "perishable_token",          :default => "",      :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "currentCity"
    t.string   "currentState"
    t.boolean  "active",                    :default => true,    :null => false
    t.boolean  "verified",                  :default => false,   :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
